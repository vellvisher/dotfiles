(setq delete-by-moving-to-trash t)

;; https://www.emacswiki.org/emacs/SystemTrash
;; See trash-directory' as it requires defining system-move-file-to-trash'.
(defun system-move-file-to-trash (file)
  "Use \"trash\" to move FILE to the system trash."
  (cl-assert (executable-find "trash") nil "'trash' must be installed. Needs \"brew install trash\"")
  (call-process (executable-find "trash") nil 0 nil file))

(use-package macos
  :vc (:url "https://github.com/xenodium/EmacsMacOSModule")
  :config
  ;; `macos-rebuild-module-and-reload' runs `swift build' via `compile',
  ;; which uses the current buffer's `default-directory'.  When that isn't
  ;; the package root, swift can't find Package.swift and the build fails.
  ;; Force the build to run from the module source root.
  (advice-add 'macos-rebuild-module-and-reload :around
              (lambda (orig &rest args)
                (let ((default-directory (macos--module-source-root)))
                  (apply orig args))))
  (macos-load-module))
;; Yank the clipboard's HTML flavor as Markdown when present.
(defun v/clipboard-html-as-markdown ()
  "Return the macOS clipboard's HTML flavor converted to Markdown, or nil.
Reads the \"public.html\" pasteboard flavor via AppleScript, decodes the
hex `«data HTML…»' payload and pipes it through pandoc."
  (let* ((script "raw=$(osascript -e 'the clipboard as «class HTML»' 2>/dev/null) || exit 0
hex=$(printf '%s' \"$raw\" | sed -E 's/^«data HTML//; s/»$//')
[ -z \"$hex\" ] && exit 0
printf '%s' \"$hex\" | xxd -r -p | pandoc -f html -t gfm-raw_html --wrap=none | sed 's/\\xc2\\xa0/ /g'")
         (out (string-trim (shell-command-to-string script))))
    (unless (string-empty-p out) out)))

(defun v/yank-or-html-markdown (&optional arg)
  "Yank, converting the clipboard's HTML flavor to Markdown when present.
Falls back to the normal `yank' (honouring ARG) when the clipboard has no
HTML flavor or the conversion yields nothing."
  (interactive "*P")
  (let ((md (v/clipboard-html-as-markdown)))
    (if md
        (progn (push-mark) (insert md))
      (yank arg))))

(global-set-key (kbd "C-S-y") #'v/yank-or-html-markdown)

(when (eq system-type 'darwin)
  (eval-and-compile (require 'eudcb-macos-contacts))
  (eudc-macos-contacts-set-server "localhost"))
(eval-when-compile (require 'message))
(define-key message-mode-map
  [(control ?c) (tab)] 'eudc-expand-inline)
(eval-when-compile (require 'sendmail))
(define-key mail-mode-map
  [(control ?c) (tab)] 'eudc-expand-inline)

;; Interactive contact lookup on top of the EUDC macOS Contacts backend.
;; `eudc-expand-inline' only completes email in a header; these commands add
;; `completing-read' (hence ivy) selection plus a details buffer.
(defun v/eudc--search (term)
  "Return macOS Contacts records matching TERM in the first or last name.
The backend can only search name/org fields (not email or phone), so we
query both name fields and merge the de-duplicated results.  Each record
is an alist of (ATTR . VALUE) cons cells; `email' and `phone' may repeat."
  (require 'eudc)
  (when (string-empty-p (string-trim term))
    (user-error "[eudc] Empty search term"))
  (delete-dups
   (mapcar #'v/eudc--clean
           (append (ignore-errors (eudc-query (list (cons 'firstname term))))
                   (ignore-errors (eudc-query (list (cons 'name term))))))))

(defun v/eudc--clean (record)
  "Drop RECORD fields whose value is the AppleScript \"missing value\" literal.
Unset first/last names are coerced to that string by the backend; removing
them keeps both the completion label and the details buffer clean."
  (seq-remove (lambda (c) (equal (cdr c) "missing value")) record))

(defun v/eudc--emails (record)
  "Return the list of email addresses in RECORD."
  (delq nil (mapcar (lambda (c) (and (eq (car c) 'email) (cdr c))) record)))

(defun v/eudc--label (record)
  "Return a one-line completion label for RECORD."
  (let ((name (string-trim
               (concat (or (cdr (assq 'first_name record)) "") " "
                       (or (cdr (assq 'last_name record)) ""))))
        (emails (v/eudc--emails record))
        (org (cdr (assq 'organization record))))
    (concat (if (string-empty-p name) "(no name)" name)
            (when emails (format " <%s>" (string-join emails ", ")))
            (when org (format " (%s)" org)))))

(defun v/eudc--pick (prompt term)
  "Search Contacts for TERM and read one record with PROMPT via completion."
  (let* ((records (v/eudc--search term)))
    (unless records
      (user-error "[eudc] No contacts match %S" term))
    (if (length= records 1)
        (car records)
      (let ((table (mapcar (lambda (r) (cons (v/eudc--label r) r)) records)))
        (cdr (assoc (completing-read prompt table nil t) table))))))

(defun v/eudc-contacts (term)
  "Search macOS Contacts for TERM, pick a match, and show its details.
Selection uses `completing-read' (ivy).  The chosen record is rendered
in the EUDC results buffer via `eudc-display-records'."
  (interactive "sSearch contacts: ")
  (eudc-display-records (list (v/eudc--pick "Contact: " term))))

(defun v/eudc-insert-email (term)
  "Search macOS Contacts for TERM and insert a chosen contact's email at point.
Prompts once more when the selected contact has multiple addresses."
  (interactive "*sSearch contacts: ")
  (let* ((record (v/eudc--pick "Contact: " term))
         (emails (v/eudc--emails record)))
    (unless emails
      (user-error "[eudc] %s has no email address" (v/eudc--label record)))
    (insert (if (length= emails 1)
                (car emails)
              (completing-read "Email: " emails nil t)))))

(define-key message-mode-map (kbd "C-c C-f") #'v/eudc-insert-email)
(define-key mail-mode-map (kbd "C-c C-f") #'v/eudc-insert-email)
