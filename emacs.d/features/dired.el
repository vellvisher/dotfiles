(require 'v-vsetq)

(use-package dired
  :hook (dired-mode . dired-hide-details-mode)
  :bind (:map dired-mode-map
              ("i" . dired-hide-details-mode))
:commands (dired-mode)
  :init
  :config
  ;; Try to guess the target directory for operations.
  (v/vsetq dired-dwim-target t)

  ;; Automatically refresh dired buffers when contents changes.
  (v/vsetq dired-auto-revert-buffer t))
