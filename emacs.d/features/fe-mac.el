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
  (macos-load-module))
;; ---- Paste browser rich text as Markdown ----
;; When you copy from a browser text field, macOS keeps an HTML flavor on the
;; clipboard alongside the plain text.  Pull that flavor and convert it to
;; Markdown with pandoc, so bold/italics/links/lists survive the paste.
(defun v/clipboard-html ()
  "Return the clipboard's HTML flavor as a string, or nil when absent.
Reads the «class HTML» pasteboard type via `osascript', which yields a hex
dump, then decodes it back to raw HTML."
  (let ((html (string-trim
               (shell-command-to-string
                (concat "osascript -e 'the clipboard as «class HTML»' 2>/dev/null"
                        " | sed -e 's/.*HTML//' -e 's/[^0-9A-Fa-f].*//'"
                        " | xxd -r -p")))))
    (unless (string-empty-p html) html)))

(defun v/yank-as-markdown ()
  "Yank the clipboard's HTML converted to Markdown via pandoc.
Falls back to a plain `yank' when the clipboard has no HTML flavor."
  (interactive)
  (let ((html (v/clipboard-html)))
    (if (not html)
        (yank)
      (insert
       (with-temp-buffer
         (insert html)
         (if (zerop (call-process-region (point-min) (point-max)
                                         "pandoc" t t nil
                                         "--from=html" "--to=gfm" "--wrap=none"))
             (string-trim-right (buffer-string))
           (user-error "pandoc failed to convert clipboard HTML")))))))

;; Cmd-Y: paste rich clipboard as Markdown (plain Cmd-V still yanks text).
(global-set-key (kbd "M-Y") #'v/yank-as-markdown)
