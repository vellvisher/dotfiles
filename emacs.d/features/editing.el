(use-package expand-region
  :ensure t
  :bind ("C-c w" . er/expand-region))

(global-auto-revert-mode 1)

(use-package hungry-delete
  :ensure t
  :config (global-hungry-delete-mode))


