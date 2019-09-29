(require 'v-vcsetq)

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

(use-package face-remap
  :bind(("M-=" . text-scale-increase)
        ("C-=" . text-scale-decrease)))

(use-package time
  :config
  (v/csetq display-time-24hr-format t)
  (v/csetq display-time-day-and-date t)

  (v/csetq display-time-string-forms
            '((format "%s %s %s, %s:%s"
                      dayname
                      monthname day
                      24-hours minutes)))
  (display-time))
