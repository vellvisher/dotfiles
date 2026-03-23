(require 'v-drag-stuff)

;; Markdown TODOs via HTML comments (invisible in all exports).
;; Format without selection: <!-- TODO: note -->
;; Format with selection:    <!-- TODO[selected text]: note -->

(defconst v/md-todo-regexp "<!-- TODO\\(?:\\[\\(.*?\\)\\]\\)?: \\(.*?\\) -->")

(defvar v/md-todo--highlight-overlay nil)

(defun v/md-add-todo (text)
  "Insert a hidden TODO comment that won't appear in exports.
With an active region, records the selected text so jumping to
this TODO highlights it in the buffer."
  (interactive "sTODO: ")
  (if (use-region-p)
      (let* ((sel (buffer-substring-no-properties (region-beginning) (region-end)))
             (sel (replace-regexp-in-string "\n" " " sel))
             (sel (if (> (length sel) 60) (substring sel 0 60) sel)))
        (goto-char (region-end))
        (deactivate-mark)
        (insert (format "<!-- TODO[%s]: %s -->" sel text)))
    (insert (format "<!-- TODO: %s -->" text))))

(defun v/md--collect-todos ()
  "Return list of (display . (marker . ref)) for all TODOs in current buffer."
  (let (todos)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward v/md-todo-regexp nil t)
        (let ((ref  (match-string 1))
              (text (match-string 2))
              (line (line-number-at-pos))
              (marker (copy-marker (match-beginning 0))))
          (push (cons (format "L%-4d  %s%s"
                              line text
                              (if ref (format "  [re: %s]" ref) ""))
                      (cons marker ref))
                todos))))
    (nreverse todos)))

(defun v/md--highlight-ref (marker ref)
  "Highlight REF text near MARKER with a temporary overlay."
  (when v/md-todo--highlight-overlay
    (delete-overlay v/md-todo--highlight-overlay)
    (setq v/md-todo--highlight-overlay nil))
  (when ref
    (with-current-buffer (marker-buffer marker)
      (save-excursion
        (let* ((pos (marker-position marker))
               (start (max (point-min) (- pos 2000)))
               (found (progn
                        (goto-char pos)
                        (or (search-backward ref start t)
                            (progn (goto-char pos)
                                   (search-forward ref (min (point-max) (+ pos 2000)) t))))))
          (when found
            (setq v/md-todo--highlight-overlay
                  (make-overlay (match-beginning 0) (match-end 0)))
            (overlay-put v/md-todo--highlight-overlay 'face 'highlight)
            (run-with-timer 3 nil (lambda ()
                                    (when v/md-todo--highlight-overlay
                                      (delete-overlay v/md-todo--highlight-overlay)
                                      (setq v/md-todo--highlight-overlay nil))))))))))

(defun v/md-ivy-todos ()
  "Browse TODOs in current markdown buffer with ivy. Jump or mark done."
  (interactive)
  (let ((todos (v/md--collect-todos))
        (buf (current-buffer)))
    (if (null todos)
        (message "No TODOs in buffer")
      (ivy-read "TODOs: " todos
                :action (lambda (item)
                          (let ((marker (cadr item))
                                (ref    (cddr item)))
                            (with-current-buffer buf
                              (goto-char marker)
                              (beginning-of-line)
                              (v/md--highlight-ref marker ref))))
                :caller 'v/md-ivy-todos))))

(ivy-set-actions
 'v/md-ivy-todos
 '(("d" (lambda (item)
          (with-current-buffer (marker-buffer (cadr item))
            (save-excursion
              (goto-char (cadr item))
              (when (re-search-forward v/md-todo-regexp (line-end-position) t)
                (replace-match "")
                (when (looking-at "^$")
                  (delete-char 1))))))
    "mark done (delete)")))

(use-package markdown-mode
  :bind (:map markdown-mode-map
         ("M-p" . v/drag-stuff-up)
         ("M-n" . v/drag-stuff-down)
         ("C-c t" . v/md-add-todo)
         ("C-c T" . v/md-ivy-todos))
  :ensure t
  :mode (("\\.text\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)))
