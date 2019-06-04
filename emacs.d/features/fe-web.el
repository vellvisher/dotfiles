;; Make URLs and e-mail addresses clickable or activatable wit <RET>.
(use-package goto-addr
  :bind (:map goto-address-highlight-keymap
              ("<RET>" . goto-address-at-point)
              ("M-<RET>" . newline))
  :commands (goto-address-prog-mode
             goto-address-mode))
