(use-package bazel-mode
  :ensure t
  :mode (("\\.bzl\\'" . bazel-mode)
         ("BUILD\\'" . bazel-mode))
  :hook (bazel-mode . v/bazel-mode-hook-function)
  :bind (:map bazel-mode-map
         (":" . v/bazel-insert-completed-target))
  :config
  (defun v/bazel-insert-completed-target ()
    (interactive)
    (self-insert-command 1)
    (if (looking-back "\":")
        (insert (completing-read
                 "Build rule: "
                 (save-excursion
                   (goto-char (point-min))
                   (let ((results '()))
                     (while (re-search-forward "name *= *\"\\(.*\\)\"" nil t)
                       (add-to-list 'results (match-string 1)))
                     (when (> (length results) 0)
                       results)))))))
  :init
  (defun v/bazel-mode-hook-function ()
    ;; Format files for me.
    (add-hook 'before-save-hook #'bazel-format t t)))
