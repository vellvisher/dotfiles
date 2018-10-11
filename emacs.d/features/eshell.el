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

    ;; Avoid "WARNING: terminal is not fully functional."
    ;; http://mbork.pl/2018-06-10_Git_diff_in_Eshell
    (setenv "PAGER" "cat")))

(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode)
  ;; If you have use-package-hook-name-suffix set to nil, uncomment and use the
  ;; line below instead:
  ;; :hook (eshell-mode-hook . esh-autosuggest-mode)
  :ensure t)
