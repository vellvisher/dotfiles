;; Ask shell for PATH, MANPATH, and exec-path and update Emacs environment.
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package eshell
  :hook ((eshell-mode . goto-address-mode)
	 (eshell-mode . v/eshell-mode-hook-function))
  :init
  (defun v/eshell-mode-hook-function ()
    ;; Turn off semantic mode in eshell
    (semantic-mode -1)
    (add-to-list 'eshell-visual-commands "ssh")

    (setq-local imenu-generic-expression '(("Prompt" " $ \\(.*\\)" 1)))

    (setq eshell-history-size (* 10 1024))
    (setq eshell-hist-ignoredups t)
    (setq eshell-error-if-no-glob t)
    (setq eshell-glob-case-insensitive t)
    (setq eshell-list-files-after-cd nil)

    ;; Avoid "WARNING: terminal is not fully functional."
    ;; http://mbork.pl/2018-06-10_Git_diff_in_Eshell
    (setenv "PAGER" "cat")))

(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode)
  ;; If you have use-package-hook-name-suffix set to nil, uncomment and use the
  ;; line below instead:
  ;; :hook (eshell-mode-hook . esh-autosuggest-mode)
  :ensure t)
(use-package term
  :bind (:map term-mode-map
	      ;; Make same shortcut DWIM to switch between line and char.
  	      ("C-x C-j" . 'term-char-mode))
  :config
  ;; https://stackoverflow.com/a/23691628
  (defadvice term-handle-exit
    (after term-kill-buffer-on-exit activate)
    (kill-buffer)))
