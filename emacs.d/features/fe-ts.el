(require 'v-vsetq)

(use-package typescript-mode
  :mode ("\\.ts\\'" . dart-mode)
  :ensure t
  :config
  (v/vsetq typescript-indent-level 2))
