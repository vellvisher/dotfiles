(require 'v-vsetq)

;; stop creating backup~ files
(v/vsetq make-backup-files nil)

;; Avoid creating lock files (ie. .#some-file.el)
(v/vsetq create-lockfiles nil)

(use-package autorevert
  :config
  ;; Auto refresh dired.
  ;; https://mixandgo.com/learn/how-ive-convinced-emacs-to-dance-with-ruby
  (v/vsetq global-auto-revert-non-file-buffers t)

  ;; Be quiet about dired refresh.
  (v/vsetq auto-revert-verbose nil)

  (global-auto-revert-mode))

(use-package files
  :config
  ;; Disable backup.
  ;; From: http://anirudhsasikumar.net/blog/2005.01.21.html
  (v/vsetq backup-inhibited t)
  ;; Ensure files end with newline.
  (v/vsetq require-final-newline t)
  ;; Disable auto save.
  ;; From: http://anirudhsasikumar.net/blog/2005.01.21.html
  (v/vsetq auto-save-default nil)

  ;; I've inadvertedly exited Emacs far too many times.
  ;; Ask for confirmation.
  (v/vsetq confirm-kill-emacs 'yes-or-no-p))

(use-package recentf
  :config
  (v/vsetq recentf-max-saved-items 1000
           recentf-max-menu-items 50)
  (use-package recentf-ext
    :ensure t)
  (recentf-mode +1))
