;; Ask shell for PATH, MANPATH, and exec-path and update Emacs environment.
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; Avoid "WARNING: terminal is not fully functional."
;; http://mbork.pl/2018-06-10_Git_diff_in_Eshell
(setenv "PAGER" "cat")

  
