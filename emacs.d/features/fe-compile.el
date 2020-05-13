(use-package compile
  :bind (:map prog-mode-map ("C-c C-c" . recompile))
  :custom
  (compilation-auto-jump-to-first-error nil))
