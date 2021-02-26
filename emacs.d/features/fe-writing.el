;; Mode for distraction-free writing and editing.
(use-package writegood-mode
  :ensure t)

(use-package writeroom-mode
  :defer 20
  :ensure t
  :hook ((writeroom-mode . v/writeroom-mode-hook))
  :config
  (defun v/writeroom-mode-hook ()
    (interactive)
    (writegood-mode +1)
    (turn-on-auto-fill)))

(defalias 'v/wc 'count-words)
