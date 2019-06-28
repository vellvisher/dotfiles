(require 'v-vcsetq)
(use-package ediff
  :config
  ;; From https://oremacs.com/2015/01/17/setting-up-ediff/
  (v/csetq ediff-window-setup-function 'ediff-setup-windows-plain)
  (v/csetq ediff-split-window-function 'split-window-horizontally)
  (winner-mode)
  (add-hook 'ediff-after-quit-hook-internal 'winner-undo))
