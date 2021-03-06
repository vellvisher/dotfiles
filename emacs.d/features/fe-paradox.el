(use-package fullframe)
(use-package paradox
  :ensure t
  :commands (paradox-list-packages)
  :custom
  (paradox-github-token t)
  :bind (:map
         paradox-menu-mode-map
         ("/" . paradox-filter-regexp))
  :config
  (fullframe paradox-list-packages paradox-quit-and-close))
