(use-package projectile
  :ensure t
  :defer 2
  :config
  (setq projectile-enable-caching t)
  (setq projectile-completion-system 'ivy)
  ;; fd is super fast. Use it if available.
  (when (executable-find "fd")
    (let ((fd-command "fd . --print0 --absolute-path"))
      (setq projectile-hg-command fd-command)
      (setq projectile-git-command fd-command)
      (setq projectile-fossil-command fd-command)
      (setq projectile-bzr-command fd-command)
      (setq projectile-darcs-command fd-command)
      (setq projectile-svn-command fd-command)
      (setq projectile-generic-command fd-command)))
  (projectile-mode))