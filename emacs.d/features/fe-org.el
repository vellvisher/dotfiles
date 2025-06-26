(require 'v-vsetq)

;; Like org-bullets but for priorities.
(use-package org-fancy-priorities
  :ensure t
  :hook
  (org-mode . org-fancy-priorities-mode)
  :custom
  (org-fancy-priorities-list '("HIGH" "MID" "LOW" "OPTIONAL")))

(use-package org
  :ensure t
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c c" . org-capture)
         ("C-c l" . org-store-link)
         ("C-c t" . org-set-tags-command)
         ("C-c p" . org-priority)
         :map org-mode-map
         ("C-c C-l" . org-insert-link))
  :hook ((org-mode . prettify-symbols-mode)
         (org-mode . org-indent-mode)
         (org-mode . flyspell-mode)
         (org-mode . v/org-mode-hook-function))
  :custom
  (org-priority-faces '((?A . "#ff2600")
                        (?B . "#ff9200")
                        (?C . "#747474")))
  (org-default-priority ?C)
  (org-use-speed-commands t)
  (org-list-use-circular-motion t)
  (org-log-done 'time)
  :config
  (defun v/org-mode-hook-function ()
    (toggle-truncate-lines 0)
    (org-display-inline-images)
    (v/vsetq show-trailing-whitespace t)
    (v/vsetq org-imenu-depth 4)
    (set-fill-column 1000)

    (v/vsetq prettify-symbols-alist '(("lambda" . ?λ)
                                      ("->" . ?→)
                                      ("<->" . ?↔))))
  (v/vsetq org-directory "~/GoogleDriveGmail/org")
  (v/vsetq org-default-notes-file (concat org-directory "/inbox.org"))
  (v/vsetq org-return-follows-link t)
  (v/vsetq org-catch-invisible-edits 'error)

  ;; Cleaner outline for org.
  (v/vsetq org-hide-leading-stars t)
  (v/vsetq org-ellipsis "…")

  ;; Replace with ivy-reveal.
  (bind-key "C-c C-r" nil org-mode-map)

  (v/vsetq org-enforce-todo-dependencies t)

  ;; Checks if clipboard has url, converts to org-link then.
  ;; Otherwise, asks for string with prompt.
  (defun v/org-clipboard-link-or-prompt-for-input (prompt)
    (let ((value (if (s-prefix? "http" (current-kill 0))
                     (org-web-tools--org-link-for-url (current-kill 0))
                   (read-string prompt))))
      (format "* TODO %s" value)))

  ;; Prompts for book name or url and returns TODO with proper link.
  (defun v/org-capture-book-template ()
    (v/org-clipboard-link-or-prompt-for-input "Book name or url:"))

  ;; Prompts for movie name or url and returns TODO with proper link.
  (defun v/org-capture-movie-template ()
    (v/org-clipboard-link-or-prompt-for-input "Movie name or url:"))

  ;; Prompts for article name or url and returns TODO with proper link.
  (defun v/org-capture-article-template ()
    (v/org-clipboard-link-or-prompt-for-input "Article name or url:"))

  ;; Prompts for emacs url or function.
  (defun v/org-capture-emacs-template ()
    (v/org-clipboard-link-or-prompt-for-input "Emacs resource:"))

  (defun v/org-capture-packing-list nil (let ((code (read-string "Dest or airport code:")))
                                          (format "* TODO <%s> packing list
SCHEDULED: <2019-12-21 Sat>

+ [ ] Toothbrush/paste
+ [ ] contact lenses
+ [ ] satin floss
+ [ ] underwear
+ [ ] socks
+ [ ] vest
+ [ ] t shirts
+ [ ] trousers
+ [ ] shorts
+ [ ] night wear
+ [ ] house keys
+ [ ] documents
  + [ ] passport
  + [ ] residence permit
  + [ ] pcr test
  + [ ] passenger locator
  + [ ] arrival test
+ [ ] dance shoes
+ [ ] perfume
+ [ ] mint
+ [ ] cosmetics
+ [ ] shaving kit
+ [ ] swimming shorts
+ [ ] spike ball
+ [ ] condoms
+ [ ] iPhone charger
+ [ ] Bose headphones
+ [ ] eye mask
+ [ ] traveling pillow
+ [ ] empty water bottle" code)))

  (defun v/org-capture-flight-checklist nil
    (let ((code (read-string "Dest airport code:"))
          (ref (read-string "Booking reference:")))
      (format "* TODO <%s> Booked flight checklist
Booking reference: %s
+ [ ] select seat
+ [ ] check in reminder
+ [ ] book special meal
" code ref)))

  (setq org-capture-templates
        '(("t" "TODO" entry (file+headline "~/GoogleDriveGmail/org/inbox.org" "Inbox")
           "* TODO %?\nSCHEDULED: %^t")
          ("s" "Shop" entry (file+headline "~/GoogleDriveGmail/org/inbox.org" "Inbox")
           "* TODO Buy %?  :shopping:\nSCHEDULED: %^t")
          ("b" "Book" entry (file "~/GoogleDriveGmail/org/books.org")
           #'v/org-capture-book-template)
          ("e" "Emacs resource" entry (file "~/GoogleDriveGmail/org/emacs.org")
           #'v/org-capture-emacs-template)
          ("a" "Article" entry (file "~/GoogleDriveGmail/org/articles.org")
           #'v/org-capture-article-template)
          ;; Prevent conflict with mail
          ("f" "Film/Movies" entry (file "~/GoogleDriveGmail/org/movies.org")
           #'v/org-capture-movie-template)
          ("p" "Packing list" entry (file+headline "~/GoogleDriveGmail/org/inbox.org" "Inbox")
           #'v/org-capture-packing-list)
          ("f" "Flight checklist" entry (file+headline "~/GoogleDriveGmail/org/inbox.org" "Inbox")
           #'v/org-capture-flight-checklist)
          ;; Eg. "~/GoogleDriveGmail/org/work.org"
          ("w" "Work" entry (file+headline v-work-org-filename "Inbox")
           "* TODO %?\nSCHEDULED: %^t")
          ("j" "Journelly" entry (file "/Users/vaarnan/Library/Mobile Documents/iCloud~com~xenodium~Journelly/Documents/Journelly.org")
           "* %U @ %(journelly-generate-metadata)\n%?" :prepend t)
          ("m" "Mail" entry (file+headline "~/GoogleDriveGmail/org/inbox.org" "Inbox")
           "* TODO %?\nSCHEDULED: %^t\n%a\n"))))

(use-package org-journal
  :ensure t
  :hook ((org-journal-mode . org-indent-mode)
         (org-journal-after-entry-create . org-indent-mode))
  :custom ((org-journal-file-format "%Y%m%d.org")
           (org-journal-dir "~/GoogleDriveGmail/org/journal")
           (org-journal-file-type 'weekly)
           (org-journal-date-format "%a %d %b, %Y")))

(use-package org-agenda
  :hook((org-agenda-mode . v/org-agenda-mode-hook-function))
  :commands org-agenda
  ;; Suggestion from:
  ;; https://blog.aaronbieber.com/2016/09/25/agenda-interactions-primer.html
  :bind (("C-c a" . v-pop-to-org-agenda)
         :map org-agenda-mode-map
         ("P" . v-org-agenda-previous-header)
         ("N" . v-org-agenda-next-header)
         ("G" . org-agenda-goto-date)
         ("C-c C-s" . v-org-agenda-schedule-safe))
  :custom
  ((org-agenda-custom-commands
    '(("d" "Daily agenda and all TODOs"
       ((agenda "" ((org-agenda-span 1)))
        (alltodo ""
                 ((org-agenda-overriding-header "Unscheduled:")
                  (org-agenda-skip-function
                   '(or (v-org-skip-category-not-inbox)
                        (org-agenda-skip-entry-if 'todo '("DONE" "OBSOLETE" "CANCELLED"))
                        (org-agenda-skip-if nil '(scheduled deadline))))))
        ))))
   (org-agenda-compact-blocks t))

  :config
  (defun v-org-skip-category-not-inbox ()
    "Skip an agenda entry if it has a CATEGORY property not equal to \"inbox\"."
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (if (string= (org-entry-get nil "CATEGORY") "inbox")
          nil
        subtree-end)))
  (defun v-pop-to-org-agenda (&optional split)
    "Visit the org agenda, in the current window or a SPLIT."
    (interactive "P")
    (org-agenda nil "d"))
  (defun v/org-agenda-mode-hook-function ()
    (add-to-list 'org-agenda-files (concat org-directory "/inbox.org"))
    (add-to-list 'org-agenda-files v-work-org-filename)

    (hl-line-mode +1)
    (goto-address-mode +1)

    (v/vsetq org-agenda-use-time-grid nil)
    (v/vsetq org-agenda-sticky nil))
  (defun v-org-agenda-next-header ()
    "Jump to the next header in an agenda series."
    (interactive)
    (v--org-agenda-goto-header))

  (defun v-org-agenda-previous-header ()
    "Jump to the previous header in an agenda series."
    (interactive)
    (v--org-agenda-goto-header t))

  (defun v-org-agenda-schedule-safe (arg &optional time)
    "Schedule the item at point safely, ignoring command if there are marks"
    (interactive "P")
    (if (not (equal org-agenda-bulk-marked-entries nil))
        (error "Note: Use bulk schedule command instead")
      (org-agenda-schedule arg time)))

  (defun v--org-agenda-goto-header (&optional backwards)
    "Find the next agenda series header forwards or BACKWARDS."
    (let ((pos (save-excursion
                 (goto-char (if backwards
                                (line-beginning-position)
                              (line-end-position)))
                 (let* ((find-func (if backwards
                                       'previous-single-property-change
                                     'next-single-property-change))
                        (end-func (if backwards
                                      'max
                                    'min))
                        (all-pos-raw (list (funcall find-func (point) 'org-agenda-structural-header)
                                           (funcall find-func (point) 'org-agenda-date-header)))
                        (all-pos (cl-remove-if-not 'numberp all-pos-raw))
                        (prop-pos (if all-pos (apply end-func all-pos) nil)))
                   prop-pos))))
      (if pos (goto-char pos))
      (if backwards (goto-char (line-beginning-position))))))

(use-package org-web-tools
  :after org
  :defer 5
  :ensure t)

(use-package org-bullets
  :ensure t
  :after org
  :hook
  (org-mode . org-bullets-mode))

;; org-goto (C-c C-j)
(use-package org-goto
  :custom
  (org-goto-interface 'outline-path-completion)
  (org-outline-path-complete-in-steps nil))

;; https://emacs.stackexchange.com/questions/5465/how-to-migrate-markdown-files-to-emacs-org-mode-format
(defun v/markdown-convert-buffer-to-org ()
  "Convert the current buffer's content from markdown to orgmode format and save it with the current buffer's file name but with .org extension."
  (interactive)
  (shell-command-on-region (point-min) (point-max)
                           (format "pandoc -f markdown -t org -o \"%s\""
                                   (concat (file-name-sans-extension (buffer-file-name)) ".org"))))

(use-package org-super-agenda
  :ensure t
  :after org-agenda
  :custom
  (org-super-agenda-groups
   '((:name "High priority"
            :and(:priority "A" :category "inbox"))
     (:name "Category: work"
            :category "work")
     (:name "Category: inbox"
            :category "inbox")
     (:name "Category: habit"
            :category "daily")))

  :config
  (org-super-agenda-mode +1))

;; (use-package literate-calc-mode
;;   :ensure t
;;   :defer 10)

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.1))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.05))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.01))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.005))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))

(use-package company-org-block
  :ensure t
  :custom
  (company-org-block-edit-style 'auto) ;; 'auto, 'prompt, or 'inline
  :hook ((org-mode . (lambda ()
                       (setq-local company-backends '(company-org-block))
                       (company-mode +1)))))

(use-package ox
  :after org
  :config
  (defun v/html-body-id-filter (output backend info)
    "Remove random ID attributes generated by Org."
    (when (eq backend 'html)
      (replace-regexp-in-string
       " href=\"#org[[:alnum:]]\\{7\\}\""
       ""
       (replace-regexp-in-string
        " id=\"[[:alpha:]-]*org[[:alnum:]]\\{7\\}\""
        ""
        output t) t)))

  (add-to-list 'org-export-filter-final-output-functions 'v/html-body-id-filter))

(defun v/org-export-to-html-after-save-for-current-buffer()
  (interactive)
  (setq v/org-export-to-html-buffer-name (buffer-name))
  ;; Auto-export org files to html when save.
  (defun v/org-mode-export-hook()
    "Auto export html"
    (when (and (eq major-mode 'org-mode) (eq (buffer-name) v/org-export-to-html-buffer-name))
      (org-html-export-to-html t)))
  (add-hook 'after-save-hook #'v/org-mode-export-hook))

(use-package org-roam
  :ensure t
  :after org
  :init (setq org-roam-v2-ack t) ;; Acknowledge V2 upgrade
  :custom
  (org-roam-directory (file-truename "~/GoogleDriveGmail/org/roam"))
  :config
  (org-roam-setup)
  (org-roam-db-autosync-mode)
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n r" . org-roam-node-random)
         (:map org-mode-map
               (("C-c n i" . org-roam-node-insert)
                ("C-c n o" . org-id-get-create)
                ("C-c n t" . org-roam-tag-add)
                ("C-c n a" . org-roam-alias-add)
                ("C-c n l" . org-roam-buffer-toggle)))))
