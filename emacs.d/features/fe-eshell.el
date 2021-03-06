(require 'v-vcsetq)
(require 'v-vsetq)

;; Ask shell for PATH, MANPATH, and exec-path and update Emacs environment.
(use-package exec-path-from-shell
  :ensure t
  :config (exec-path-from-shell-initialize))
(use-package shell-pop
  :ensure t
  :bind (("C-c C-h" . v/shell-pop))
  :config (use-package eshell
            :hook ((eshell-mode . goto-address-mode)
                   (eshell-mode . v/eshell-mode-hook-function)
                   (term-exec . view-mode))
            :init (defun v/eshell-mode-hook-function ()
                    ;; Turn off semantic mode in eshell
                    (semantic-mode -1)
                    (add-to-list 'eshell-visual-commands "ssh")
                    (add-to-list 'eshell-visual-commands "adb")

                    (add-to-list 'eshell-visual-subcommands '("hg" "log" "diff" "split"))

                    (setq-local imenu-generic-expression '(("Prompt" " $ \\(.*\\)" 1)))
                    (v/vsetq eshell-history-size (* 10 1024))
                    (v/vsetq eshell-hist-ignoredups t)
                    (v/vsetq eshell-error-if-no-glob t)
                    (v/vsetq eshell-glob-case-insensitive t)
                    (v/vsetq eshell-list-files-after-cd nil)
                    (v/vsetq eshell-save-history-index t)

                    (v/vsetq eshell-banner-message "Welcome back V

                    ")

                    (bind-keys :map eshell-mode-map
                               ("M-i" . v/eshell-counsel-history))

                    ;; https://www.reddit.com/r/emacs/comments/799qq3/helmeshpcomplete_like_behavior_with_ivy_in_eshell/
                    (define-key eshell-mode-map (kbd "<tab>") 'completion-at-point)

                    ;; Avoid "WARNING: terminal is not fully functional."
                    ;; http://mbork.pl/2018-06-10_Git_diff_in_Eshell
                    (setenv "PAGER" "cat")))
  (defun adviced:eshell-exec-visual (orig-fun &rest r)
    ;; Don't let visual commands keep creating multiple buffers.
    ;; Kill it first if it already exists.
    (cl-letf (((symbol-function #'generate-new-buffer)
               (lambda (name)
                 (when (get-buffer name)
                   (kill-buffer name))
                 (get-buffer-create (generate-new-buffer-name name)))))
      (apply orig-fun r)))

  (advice-add #'eshell-exec-visual
              :around
              #'adviced:eshell-exec-visual)
  ;; Must use custom set for these.
  (v/csetq shell-pop-window-position "full")
  (v/csetq shell-pop-shell-type '("eshell" "*eshell*" (lambda ()
                                                        (eshell))))
  (v/csetq shell-pop-term-shell "eshell")
  (defun v/eshell-counsel-history ()
    (interactive)
    (let ((history eshell-history-ring)
          (selection nil))
      (with-temp-buffer
        (setq eshell-history-ring history)
        (counsel-esh-history)
        (setq selection (buffer-string)))
      (delete-region eshell-last-output-end (line-end-position))
      (insert selection)))
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
  :bind (:map
         term-mode-map
         ("C-c C-j" . v/term-toggle-mode)
         ("C-c C-k" . v/term-toggle-mode)
         :map
         term-raw-map
         ("C-c C-j" . v/term-toggle-mode)
         ("C-c C-k" . v/term-toggle-mode)
         ("C-c C-h" . v/shell-pop))
  :config
  ;; https://joelmccracken.github.io/entries/switching-between-term-mode-and-line-mode-in-emacs-term
  (defun v/term-toggle-mode ()
    "Toggle term between line mode and char mode."
    (interactive)
    (if (term-in-line-mode)
        (term-char-mode)
      (term-line-mode))))
;; :config
;; https://stackoverflow.com/a/23691628
;; (defadvice term-handle-exit
;;     (after term-kill-buffer-on-exit activate)
;;   (kill-buffer)))
;; (use-package term
;;   :init
;;   (v/vsetq explicit-shell-file-name "/bin/bash"))
;;  (add-hook 'term-mode-hook
;;            (function
;;             (lambda ()
;;                   (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
;;                   (setq-local mouse-yank-at-point t)
;;                   (v/vsetq explicit-shell-file-name "/bin/bash")
;;                   (setq-local transient-mark-mode nil)
;;                   (auto-fill-mode -1)
;;                   (setq tab-width 8 ))))

(use-package eshell-up
  :ensure t
  :config
  (defalias 'eshell/up #'eshell-up))

(use-package em-smart
  :hook
  ((eshell-mode . eshell-smart-initialize)))
