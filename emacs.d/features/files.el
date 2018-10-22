;; stop creating backup~ files
(setq make-backup-files nil)
;; stop creating #autosave# files
(setq auto-save-default nil)
;; Avoid creating lock files (ie. .#some-file.el)
(setq create-lockfiles nil)

(use-package autorevert
  :config
  ;; Auto refresh dired.
  ;; https://mixandgo.com/learn/how-ive-convinced-emacs-to-dance-with-ruby
  (setq global-auto-revert-non-file-buffers t)

  ;; Be quiet about dired refresh.
  (setq auto-revert-verbose nil)

  (global-auto-revert-mode))
