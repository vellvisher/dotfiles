(use-package bazel-mode
  :ensure t
  :mode (("\\.bzl\\'" . bazel-mode)
         ("BUILD\\'" . bazel-mode))
  :hook (bazel-mode . v/bazel-mode-hook-function)
  :init
  (defun v/bazel-mode-hook-function ()
    ;; Format files for me.
    (add-hook 'before-save-hook #'bazel-format t t)))
