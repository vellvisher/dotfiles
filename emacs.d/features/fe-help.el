(require 'v-vsetq)
(require 'v-vcsetq)

(use-package help
  :hook (help-mode . goto-address-mode)
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

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (v/csetq which-key-idle-delay 0.5))
