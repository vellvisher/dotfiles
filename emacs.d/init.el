;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.
(setq load-prefer-newer t)

(require 'package)

;; Don't auto-initialize.
(setq package-enable-at-startup nil)

;; Don't add that `custom-set-variables' block to init.
(setq package--init-file-ensured t)

;; Point custom variable to empty file.
(setq custom-file "~/.emacs-custom.el")
(load custom-file)

(setq package-archives
      '(("melpa" . "http://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

(setq package-archive-priorities
      '(("melpa" .  4)
        ("melpa-stable" . 3)
        ("org" . 2)
        ("gnu" . 1)))

(package-initialize)

;; Match theme color early on (smoother transition).
;; Theme loaded in features/fe-ui.el.
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

;; use-package-enable-imenu-support must be
;; set before requiring use-package.
(setq use-package-enable-imenu-support t)
(require 'use-package)

(use-package solarized-theme
  :ensure t
  :init
  (load-theme 'solarized-dark t))

(use-package clang-format
  :ensure t
  :init
  (setq clang-format-executable "/usr/local/bin/clang-format"))

(set-face-attribute 'default nil :height 165)

(use-package smartparens
  :ensure t
  :init
  (require 'smartparens-config))

;; Remap META to CMD
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

;; Additional load paths.
(add-to-list 'load-path "~/.emacs.d/v")
(add-to-list 'load-path "~/.emacs.d/local")
(add-to-list 'load-path "~/.emacs.d/external")

(load "~/.emacs.d/features/fe-libs.el")

(load "~/.emacs.d/features/fe-eshell.el")
(load "~/.emacs.d/features/fe-scratch.el")
(load "~/.emacs.d/features/fe-paradox.el")
(load "~/.emacs.d/features/fe-navigation.el")
(load "~/.emacs.d/features/fe-ivy.el")
(load "~/.emacs.d/features/fe-ui.el")
(load "~/.emacs.d/features/fe-editing.el")
(load "~/.emacs.d/features/fe-git.el")
(load "~/.emacs.d/features/fe-projectile.el")
(load "~/.emacs.d/features/fe-server.el")
(load "~/.emacs.d/features/fe-files.el")
(load "~/.emacs.d/features/fe-dired.el")
(load "~/.emacs.d/features/fe-prog.el")
(load "~/.emacs.d/features/fe-protobuf.el")
(load "~/.emacs.d/features/fe-objc.el")
(load "~/.emacs.d/features/fe-web.el")
(load "~/.emacs.d/features/fe-md.el")
(load "~/.emacs.d/features/fe-swift.el")
(load "~/.emacs.d/features/fe-kotlin.el")
(load "~/.emacs.d/features/fe-org.el")
(load "~/.emacs.d/features/fe-help.el")
(load "~/.emacs.d/features/fe-work.el")
(load "~/.emacs.d/features/fe-bazel.el")
(load "~/.emacs.d/features/fe-tags.el")
