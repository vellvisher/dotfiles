(require 'v-vcsetq)
(use-package ediff
  :config
  ;; From https://oremacs.com/2015/01/17/setting-up-ediff/
  (v/csetq ediff-window-setup-function 'ediff-setup-windows-plain)
  (v/csetq ediff-split-window-function 'split-window-horizontally)

  ;; winner-mode
  (winner-mode)
  (add-hook 'ediff-after-quit-hook-internal 'winner-undo)

  ;; golden-ratio disable only for ediff mode
  (add-hook 'ediff-mode-hook (lambda () (golden-ratio-mode -1)))
  (add-hook 'ediff-after-quit-hook-internal 'golden-ratio-mode))
