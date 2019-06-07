(require 'v/drag-stuff-up)
(require 'v/drag-stuff-down)

(use-package markdown-mode
  :bind (:map markdown-mode-map
         ("M-p" . v/drag-stuff-up)
         ("M-n" . v/drag-stuff-down))
  :ensure t
  :mode (("\\.text\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)))
