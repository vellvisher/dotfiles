(use-package counsel
:ensure t
:defer 0.1
:config
;; Smex handles M-x command sorting. Bringing recent commands to the top.
(use-package smex
:ensure t)
;; Wgrep is used by counsel-ag (to make writeable).
(use-package wgrep
:ensure t)
(counsel-mode +1))

(use-package ivy
:ensure t
:defer 0.1
:bind ("C-x C-b" . ivy-switch-buffer)
:config
(setq ivy-height 40)
(setq ivy-count-format "")
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(ivy-mode +1))
