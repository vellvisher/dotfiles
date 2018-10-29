;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.
(require 'package)

;; Don't add that `custom-set-variables' block to init.
(setq package--init-file-ensured t)

;; load emacs 24's package system. Add MELPA repository.
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))

(package-initialize)

;; Match theme color early on (smoother transition).
;; Theme loaded in features/ui.el.
(set-background-color "#073642")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Hide UI (early on) ;;;;

;; Don't want a mode line while loading init.
(setq mode-line-format nil)

;; No scrollbar by default.
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No nenubar by default.
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; No toolbar by default.
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; No tooltip by default.
(when (fboundp 'tooltip-mode) (tooltip-mode -1))

;; No Alarms by default.
(setq ring-bell-function 'ignore)

;; Get rid of splash screens.
(setq inhibit-splash-screen t)

(toggle-frame-fullscreen)

;; Needed for 'https' for MELPA after running on mac:
;; brew install libressl
(require 'gnutls)
(add-to-list 'gnutls-trustfiles "/usr/local/etc/openssl/cert.pem")

;; Install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(use-package solarized-theme
  :ensure t
  :init
  (load-theme 'solarized-dark t))

(use-package clang-format
  :ensure t
  :init
  (setq clang-format-executable "/usr/local/bin/clang-format"))

(set-face-attribute 'default nil :height 165)

(global-set-key "\C-w" 'backward-kill-word)

(use-package smartparens
  :ensure t
  :init
  (require 'smartparens-config))

(use-package cc-mode
  :config
  (add-hook 'before-save-hook 'clang-format-save-hook))

;; Remap META to CMD
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

(load "~/.emacs.d/features/libs.el")
(load "~/.emacs.d/features/eshell.el")
(load "~/.emacs.d/features/scratch.el")
(load "~/.emacs.d/features/paradox.el")
(load "~/.emacs.d/features/navigation.el")
(load "~/.emacs.d/features/ivy.el")
(load "~/.emacs.d/features/ui.el")
(load "~/.emacs.d/features/editing.el")
(load "~/.emacs.d/features/git.el")
(load "~/.emacs.d/features/projectile.el")
(load "~/.emacs.d/features/server.el")
(load "~/.emacs.d/features/files.el")
(load "~/.emacs.d/features/prog.el")
(load "~/.emacs.d/features/protobuf.el")
;; (load "~/.emacs.d/features/objc.el")
