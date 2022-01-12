(require 'v-vcsetq)

(use-package company-emoji
  :ensure t)

(use-package company
  :ensure t
  ;; ...
  :hook ((after-init . global-company-mode))
  :config
  (v/csetq company-minimum-prefix-length 2)
  (v/csetq company-show-quick-access t)
  (add-to-list 'company-backends 'company-emoji))
