(require 'v-vsetq)

(use-package help
  :config
  ;; Select help window by default.
  (v/vsetq help-window-select t))

(use-package helpful
  :ensure t
  :bind  (("C-h f" . helpful-callable)
          ("C-h v" . helpful-variable)
          ("C-h k" . helpful-key))
  :config
  (use-package elisp-demos
    :ensure t
    :config
    (advice-add 'helpful-update
                :after
                #'elisp-demos-advice-helpful-update)))
