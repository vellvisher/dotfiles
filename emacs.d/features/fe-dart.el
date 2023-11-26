;;; fe-dart.el --- Dart mode configuration
;;; Commentary:
;; This file contains the setup for Dart mode.
;;; Code:
(use-package dart-mode
  :mode ("\\.dart\\'" . dart-mode)
  :after reformatter
  :hook (dart-mode . v/dart-mode-hook)
  :init
  (defun dart-imenu-create-index ()
    (let* ((index-alist '()))
      (save-excursion
        (goto-char (point-min))
        (while (re-search-forward "^\\s-*\\(class\\|enum\\|[_a-zA-Z]+\\)\\s-+\\([A-Za-z_][A-Za-z0-9_]*\\)" nil t)
          (let ((declaration (match-string-no-properties 1))
                (identifier (match-string-no-properties 2)))
            (setq index-alist (cons (cons (concat declaration " " identifier) (point)) index-alist))))
        index-alist)))

  (defun v/dart-mode-hook ()
    (setq-local imenu-create-index-function #'dart-imenu-create-index)
    (imenu-add-to-menubar "INDEX")
    (when (require 'reformatter nil 'noerror)
      (reformatter-define dart-format
        :program "dart"
        :args '("format"))
      (add-hook 'dart-mode-hook #'(lambda () (dart-format-on-save-mode 1))))))
;;; fe-dart.el ends here
