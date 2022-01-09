;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Init.el GC values (faster loading) ;;;;

(setq gc-cons-threshold (* 384 1024 1024)
      gc-cons-percentage 0.6)

;; Default of 800 was too low.
;; Avoid Lisp nesting exceeding in swift-mode.
(setq max-lisp-eval-depth 3000)
(setq max-specpdl-size 3000)

;; Debug startup times
;;; Set to t to debug (load synchronously).
(defvar v/init-debug-init nil)

;; Uncomment lines
;; (setq use-package-compute-statistics t)
;; (load "~/.emacs.d/features/fe-debug.el"))

;;; Temporarily avoid loading any modes during init (undone at end).
(defvar v/init--file-name-handler-alist file-name-handler-alist)

(setq file-name-handler-alist nil)

;;;; UI (early on) ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Match theme color early on (smoother transition).
;; Theme loaded in features/fe-ui.el.
(set-background-color "#292D3E")

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

(set-face-attribute 'default nil :height 165)

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
;; https://github.com/hlissner/doom-emacs/blob/develop/early-init.el
(setq frame-inhibit-implied-resize t)

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
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "https://orgmode.org/elpa/")))

(setq package-archive-priorities
      '(("melpa" .  5)
        ("melpa-stable" . 4)
        ("nongnu" . 3)
        ("gnu" . 2)
        ("org" . 1)))

(unless package--initialized
  (package-initialize))

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

(use-package use-package-ensure-system-package
  :ensure t)

;; Remap META to CMD
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

(defun v/load-non-core-init ()
  "Load non-core initialisation."
  ;; Undo GC values post init.el.
  (setq gc-cons-threshold 100000000
        gc-cons-percentage 0.1)
  (run-with-idle-timer 5 t #'garbage-collect)
  (setq garbage-collection-messages nil)
  (setq file-name-handler-alist v/init--file-name-handler-alist)

  ;; Done loading core init.el. Announce it and let the heavy loading begin.
  (message "Emacs ready in %s with %d garbage collections."
           (format "%.2f seconds" (float-time
                                   (time-subtract after-init-time before-init-time)))
           gcs-done)

  ;; Additional load paths.
  (add-to-list 'load-path "~/.emacs.d/v")
  (add-to-list 'load-path "~/.emacs.d/local")
  (add-to-list 'load-path "~/.emacs.d/external")

  ;; Need these loaded ASAP (many subsequent libraries depend on them).
  ;; (load "~/.emacs.d/features/fe-package-extensions.el")
  (load "~/.emacs.d/features/fe-libs.el")

  ;; Load non-core features.
  (load "~/.emacs.d/features/fe-sensible.el")
  (load "~/.emacs.d/features/fe-eshell.el")
  (load "~/.emacs.d/features/fe-scratch.el")
  (load "~/.emacs.d/features/fe-paradox.el")
  (load "~/.emacs.d/features/fe-navigation.el")
  (load "~/.emacs.d/features/fe-ivy.el")
  (load "~/.emacs.d/features/fe-ui.el")
  (load "~/.emacs.d/features/fe-mc.el")
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
  (load "~/.emacs.d/features/fe-ts.el")
  (load "~/.emacs.d/features/fe-kotlin.el")
  (load "~/.emacs.d/features/fe-org.el")
  (load "~/.emacs.d/features/fe-ob.el")
  (load "~/.emacs.d/features/fe-help.el")
  (load "~/.emacs.d/features/fe-work.el")
  (load "~/.emacs.d/features/fe-bazel.el")
  (load "~/.emacs.d/features/fe-tags.el")
  (load "~/.emacs.d/features/fe-ediff.el")
  ;; disabled since unused
  ;; (load "~/.emacs.d/features/fe-gcal.el")
  (load "~/.emacs.d/features/fe-qrcode.el")
  (load "~/.emacs.d/features/fe-writing.el")
  (load "~/.emacs.d/features/fe-compile.el")
  (load "~/.emacs.d/features/fe-flyspell.el")
  (load "~/.emacs.d/features/fe-yasnippet.el")
  (load "~/.emacs.d/features/fe-buffers.el")
  (load "~/.emacs.d/features/fe-alfred-org-capture.el"))

(if v/init-debug-init
    (v/load-non-core-init)
  (add-hook
   'emacs-startup-hook
   #'v/load-non-core-init))
