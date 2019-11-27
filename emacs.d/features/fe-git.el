(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status)
  :config
  (add-to-list 'magit-no-confirm 'stage-all-changes)

  (fullframe magit-status magit-mode-quit-window))

(use-package git-gutter
 :ensure t
 :hook (prog-mode . git-gutter-mode)
 :config
 (setq git-gutter:handled-backends '(git bzr svn)))

(use-package git-link
  :ensure t
  :defer 5)
