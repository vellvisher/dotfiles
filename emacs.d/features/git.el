(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status)
  :config
  (add-to-list 'magit-no-confirm 'stage-all-changes)

  (fullframe magit-status magit-mode-quit-window))

(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :ensure t
  :config
  (setq git-gutter:handled-backends '(git hg bzr svn)))
