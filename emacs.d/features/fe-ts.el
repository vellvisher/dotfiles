(require 'v-vsetq)

(use-package typescript-mode
  :mode ("\\.ts\\'" . typescript-mode)
  :ensure t
  :config
  (v/vsetq typescript-indent-level 2)
  (add-hook 'typescript-mode-hook
            (lambda ()
              (add-hook 'before-save-hook 'prettier-js nil t)
              (setq-local whitespace-line-column 100))))

(use-package prettier-js
  :after typescript-mode
  :ensure t)
