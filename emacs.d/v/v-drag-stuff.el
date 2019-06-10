;;; v-drag-stuff.el --- drag lines up/down.

(defun v/drag-stuff-down (arg)
  (interactive "p")
  "Drag stuff ARG lines down."
  ;; TODO: Fix moving sections for Markdown.
  (if (eq major-mode 'org-mode)
      (org-metadown)
    (drag-stuff-down arg)))

;; org-metaup/down in org-mode
(defun v/drag-stuff-up (arg)
  (interactive "p")
  "Drag stuff ARG lines up."
  (if (eq major-mode 'org-mode)
      (org-metaup)
    (drag-stuff-up arg)))

(provide 'v-drag-stuff)
