(require 'v-vcsetq)

;; Make emacs full-screen which is faster than toggle-frame-fullscreen which
;; carries a 0.5s delay.
(set-frame-parameter nil 'fullscreen 'fullboth)

(use-package doom-themes
  :ensure t
  :init
  (load-theme 'doom-palenight t))

(use-package fullframe
  :ensure t
  :commands fullframe)

;; Always use y/n instead of yes/no prompts.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Display time in modeline.
(display-time-mode 1)

;; Display which function in modeline.
(use-package which-func
  :config
  (which-function-mode +1))

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

;; Emoji's: welcome back to Emacs
;; https://github.crookster.org/emacs27-from-homebrew-on-macos-with-emoji/
(when (>= emacs-major-version 27)
  (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") nil 'prepend))

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

(use-package minions
  :ensure t
  :config
  (v/csetq minions-mode-line-lighter "…")
  (v/csetq minions-mode-line-delimiters '("" . ""))
  (minions-mode +1))

(use-package golden-ratio
  :ensure t
  :config
  (v/csetq golden-ratio-auto-scale t)
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

(set-face-attribute 'default nil :stipple nil :foreground "#eeffff" :inverse-video nil
                    ;; :family "Menlo" ;; or Meslo if unavailable: https://github.com/andreberg/Meslo-Font
                    ;; :family "Hack" ;; brew tap homebrew/cask-fonts && brew cask install font-hack
                    :family "JetBrains Mono" ;; brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono
                    ;; :family "mononoki" ;; https://madmalik.github.io/mononoki/ or sudo apt-get install fonts-mononoki
                    :box nil :strike-through nil :overline nil :underline nil
                    :slant 'normal :weight 'normal :width 'normal :foundry "nil"
                    ;; Font-size / 10 is the height
                    :height 150)
