;;; -*- lexical-binding: t; -*-

;; Partially use path in buffer name.
(use-package uniquify
  :custom
  (uniquify-buffer-name-style 'forward))

(use-package menu-bar
  ;; No need to confirm killing buffers.
  :bind ("C-x k" . kill-this-buffer))

(use-package ibuffer
  :bind (:map ibuffer-mode-map)
  ("C-k" . ibuffer-do-delete))
