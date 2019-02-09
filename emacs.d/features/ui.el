(use-package fullframe
  :ensure t
  :commands fullframe)

;; Always use y/n instead of yes/no prompts.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Display time in modeline.
(display-time-mode 1)

;; Display column numbers.
(setq-default column-number-mode t)
