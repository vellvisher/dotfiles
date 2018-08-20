;; load emacs 24's package system. Add MELPA repository.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; Needed for 'https' for MELPA after running on mac:
;; brew install libressl
(require 'gnutls)
(add-to-list 'gnutls-trustfiles "/usr/local/etc/openssl/cert.pem")

;; Install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (objc-mode dummy-h-mode wgrep smex counsel ivy fullframe paradox smartparens magit expand-region use-package solarized-theme)))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(use-package solarized-theme
  :init
  (load-theme 'solarized-dark))

(use-package clang-format
  :init
  (setq clang-format-executable "/usr/local/bin/clang-format"))

(use-package expand-region)

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

(set-face-attribute 'default nil :height 165)

(global-set-key "\C-w" 'backward-kill-word)

(use-package smartparens
  :init
  (require 'smartparens-config))

(use-package cc-mode
  :config
  (add-hook 'before-save-hook 'clang-format-save-hook))

;; Remap META to CMD
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

(load "~/.emacs.d/features/paradox.el")
(load "~/.emacs.d/features/navigation.el")
(load "~/.emacs.d/features/ivy.el")
(load "~/.emacs.d/features/ui.el")
;; (load "~/.emacs.d/features/obc.el")
