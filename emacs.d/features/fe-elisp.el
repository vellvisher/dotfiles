(use-package elisp-mode
  :commands emacs-lisp-mode
  :bind ("C-x C-e" . v/eval-last-sexp)
  :config
;; Based on https://emacsredux.com/blog/2013/06/21/eval-and-replace
  (defun v/eval-last-sexp (arg)
    "Replace the preceding sexp with its value."
    (interactive "P")
    (if arg
        (progn
          (backward-kill-sexp)
          (condition-case nil
              (prin1 (eval (read (current-kill 0)))
                     (current-buffer))
            (error (message "Invalid expression")
                   (insert (current-kill 0)))))
      (let ((current-prefix-arg nil))
        (call-interactively 'pp-eval-last-sexp)))))
