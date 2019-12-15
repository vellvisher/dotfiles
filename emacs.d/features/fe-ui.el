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

;; Move `mode-line-modes` to the end of the mode-line.
(v/csetq mode-line-format
'("%e" mode-line-front-space mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification "   " mode-line-position
 (vc-mode vc-mode)
 "  " mode-line-misc-info mode-line-modes mode-line-end-spaces))

(use-package golden-ratio
  :ensure t
  :init
  (golden-ratio-mode 1))

;; In addition to highlighting symbols, we get navigation between them.
(use-package symbol-overlay
  :ensure t
  :hook (prog-mode . symbol-overlay-mode)
  :config
  ;; Override overlay background color with default background
  ;; to get rid of overlay bounding box.
  (set-face-attribute 'symbol-overlay-default-face nil
                      :background (face-attribute 'default :background)
                      :foreground "yellow"))

;; Highlight matching parenthesis.
(use-package paren
  :ensure t
  :defer 5
  :config
  (show-paren-mode +1)
  ;; Without this matching parens aren't highlighted in region.
  (v/vsetq show-paren-priority -50)
  (v/vsetq show-paren-delay 0)
  ;; Highlight entire bracket expression.
  (v/vsetq show-paren-style 'mixed)
  (set-face-attribute 'show-paren-match nil
                      :background nil
                      :foreground "#FA009A"))
