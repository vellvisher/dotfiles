(require 'v-vcsetq)

(use-package bazel-mode
  :ensure t
  :mode (("\\.bzl\\'" . bazel-mode)
         ("BUILD\\'" . bazel-mode))
  :hook (bazel-mode . v/bazel-mode-hook-function)
  :bind (:map bazel-mode-map
              (":" . v/bazel-insert-completed-target))
  :config
  (defun v/bazel-insert-completed-target ()
    (interactive)
    (self-insert-command 1)
    (if (looking-back "\":")
        (insert (completing-read
                 "Build rule: "
                 (save-excursion
                   (goto-char (point-min))
                   (let ((results '()))
                     (while (re-search-forward "name *= *\"\\(.*\\)\"" nil t)
                       (add-to-list 'results (match-string 1)))
                     (when (> (length results) 0)
                       results)))))))
  (defun v/bazel-jump-to-build-rule ()
    "Jump to the closest BUILD rule for current file."
    (interactive)
    (let* (;; path/to/root/package/subpackage (from path/to/root/package/subpackage/BUILD)
           (package-dpath (expand-file-name
                           (or (locate-dominating-file default-directory "BUILD")
                               (error "No BUILD found."))))
           ;; source.swift
           (fname (replace-regexp-in-string package-dpath
                                            "" (expand-file-name
                                                (or buffer-file-name
                                                    (error "Not visiting a file")))))
           ;; search for "source.swift"
           (needle (format "\"%s\"" fname)))
      (find-file (concat (file-name-as-directory package-dpath) "BUILD"))
      (goto-char (point-min))
      ;; search for "source.swift"
      (re-search-forward needle)
      (backward-char (length needle))))

  :init
  (defun v/bazel-mode-hook-function ()
    ;; Format files for me.
    (v/csetq bazel-mode-buildifier-before-save t)
    ;; Add imenu support
    ;; Replace python-imenu-create-index with the default one
    (setq-local imenu-create-index-function #'imenu-default-create-index-function)

    ;; Simple regex over method names
    (setq-local imenu-generic-expression
                '(("Build rule" "name *= *\"\\(.*\\)\"" 1)))))
