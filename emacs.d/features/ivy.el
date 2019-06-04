(require 'v-vsetq)

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
  :bind (("C-x C-b" . ivy-switch-buffer)
         :map ivy-minibuffer-map
         ("C-g" . v/ivy-keyboard-quit-dwim))
  :config
  (v/vsetq ivy-height 15)
  (v/vsetq ivy-count-format "")
  (v/vsetq ivy-use-virtual-buffers t)
  (v/vsetq enable-recursive-minibuffers t)
  (defun v/ivy-keyboard-quit-dwim ()
    "If region active, deactivate. If there's content, minibuffer. Otherwise quit."
    (interactive)
    (cond ((and
            delete-selection-mode
            (region-active-p))
           (setq deactivate-mark t))
          ((> (length ivy-text) 0)
           (delete-minibuffer-contents))
          (t (minibuffer-keyboard-quit))))
  (ivy-mode +1))

(use-package counsel-projectile
  :ensure t
  :bind ("C-x f" . counsel-projectile-find-file))

(use-package ivy-hydra
  :ensure t)

(use-package ivy-rich
  :ensure t
  :config
  (setq ivy-rich--display-transformers-list
        '(counsel-M-x
          (:columns
           ((counsel-M-x-transformer (:width 80))  ; the original transfomer
            (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))))
  (ivy-rich-mode +1))
