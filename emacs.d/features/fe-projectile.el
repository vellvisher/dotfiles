(use-package ripgrep
  :ensure t)

(use-package projectile
  :ensure-system-package fd
  :defer 2
  :bind (("C-c s" . counsel-projectile-rg))
  :config
  (setq projectile-enable-caching t)
  (setq projectile-completion-system 'ivy)
  (setq projectile-indexing-method 'hybrid)

  (setq projectile-ignored-projects '("~/"))
  ;; fd is super fast. Use it if available.

  (let ((fd-command "fd . --print0"))
    (setq projectile-hg-command fd-command)
    (setq projectile-git-command fd-command)
    (setq projectile-fossil-command fd-command)
    (setq projectile-bzr-command fd-command)
    (setq projectile-darcs-command fd-command)
    (setq projectile-svn-command fd-command)
    (setq projectile-generic-command fd-command))
  (projectile-mode))
