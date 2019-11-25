(setq initial-scratch-message nil)

;; Remember scratch content across sessions.
(use-package persistent-scratch
  :ensure t
  :config
  (with-current-buffer "*scratch*"
    (emacs-lock-mode 'kill))
  (persistent-scratch-setup-default))
