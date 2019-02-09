(require 'v-vsetq)

;; https://oremacs.com/2015/01/17/setting-up-ediff
;; Macro for setting custom variables.
;; Similar to custom-set-variables, but more like setq.
;; TODO(vaarnan): Move to v/csetq.
(defmacro csetq (variable value) 
  `(funcall (or (get ',variable 'custom-set) 
		'set-default) ',variable ,value))

;; Ask shell for PATH, MANPATH, and exec-path and update Emacs environment.
(use-package exec-path-from-shell 
  :ensure t 
  :config (exec-path-from-shell-initialize))
(use-package shell-pop 
  :ensure t 
  :bind (([f5] . v/shell-pop)) 
  :config (use-package eshell 
	    :hook ((eshell-mode . goto-address-mode) 
		   (eshell-mode . v/eshell-mode-hook-function)) 
	    :init (defun v/eshell-mode-hook-function ()
		    ;; Turn off semantic mode in eshell
		    (semantic-mode -1) 
		    (add-to-list 'eshell-visual-commands "ssh")
		    (setq-local imenu-generic-expression '(("Prompt" " $ \\(.*\\)" 1)))
		    (v/vsetq eshell-history-size (* 10 1024)) 
		    (v/vsetq eshell-hist-ignoredups t) 
		    (v/vsetq eshell-error-if-no-glob t) 
		    (v/vsetq eshell-glob-case-insensitive t) 
		    (v/vsetq eshell-list-files-after-cd nil)
                    
                    (v/vsetq eshell-banner-message "Welcome back V

                    ")

		    ;; https://www.reddit.com/r/emacs/comments/799qq3/helmeshpcomplete_like_behavior_with_ivy_in_eshell/
		    (define-key eshell-mode-map (kbd "<tab>") 'completion-at-point)

		    ;; Avoid "WARNING: terminal is not fully functional."
		    ;; http://mbork.pl/2018-06-10_Git_diff_in_Eshell
		    (setenv "PAGER" "cat")))

  ;; Must use custom set for these.
  (csetq shell-pop-window-position "full") 
  (csetq shell-pop-shell-type '("eshell" "*eshell*" (lambda () 
						      (eshell)))) 
  (csetq shell-pop-term-shell "eshell")
  (defun v/shell-pop (shell-pop-autocd-to-working-dir) 
    "Shell pop with arg to cd to working dir. Else use existing location." 
    (interactive "P")
    ;; shell-pop-autocd-to-working-dir is defined in shell-pop.el.
    ;; Using lexical binding to override.
    (if (string= (buffer-name) shell-pop-last-shell-buffer-name) 
	(shell-pop-out) 
      (shell-pop-up shell-pop-last-shell-buffer-index))))

(use-package esh-autosuggest 
  :hook (eshell-mode . esh-autosuggest-mode)
  ;; If you have use-package-hook-name-suffix set to nil, uncomment and use the
  ;; line below instead:
  ;; :hook (eshell-mode-hook . esh-autosuggest-mode)
  :ensure t)

(use-package term
  :bind (:map term-mode-map
	      ;; Make same shortcut DWIM to switch between line and char.
  	      ("C-x C-j" . term-char-mode)
	      :map term-raw-map
	      ;; Prefix is actually C-x.
	      ("C-c C-y" . term-paste))
  :config
  ;; https://stackoverflow.com/a/23691628
  (defadvice term-handle-exit
    (after term-kill-buffer-on-exit activate)
    (kill-buffer)))
;; (use-package term
;;   :init
;;   (v/vsetq explicit-shell-file-name "/bin/bash"))
;;  (add-hook 'term-mode-hook
;;  	      (function
;;  	       (lambda ()
;;  	             (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
;;  	             (setq-local mouse-yank-at-point t)
;;                   (v/vsetq explicit-shell-file-name "/bin/bash")
;;  	             (setq-local transient-mark-mode nil)
;;  	             (auto-fill-mode -1)
;;  	             (setq tab-width 8 ))))
