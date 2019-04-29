(use-package fullframe
  :ensure t
  :commands fullframe)

;; Always use y/n instead of yes/no prompts.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Display time in modeline.
(display-time-mode 1)

;; Display battery level in modeline.
(use-package battery
  :config
  (when (and battery-status-function
       (not (string-match-p "N/A"
                (battery-format "%B"
                        (funcall battery-status-function)))))
  (display-battery-mode 1)))

;; Display column numbers.
(setq-default column-number-mode t)
