(require 'v-vsetq)

(use-package clang-format
  :ensure t
  :init
  (setq clang-format-executable "/usr/local/bin/clang-format"))

(use-package prog-mode
  :bind (:map prog-mode-map ("M-'" . xref-find-references))
  :hook ((prog-mode . flyspell-prog-mode)
         (prog-mode . company-mode)
         (prog-mode . goto-address-prog-mode)
         (prog-mode . prettify-symbols-mode)
         (prog-mode . rainbow-mode)
         (prog-mode . v/prog-mode-hook-function))
  ;; (prog-mode . flycheck-mode)
  ;; (prog-mode . company-mode)
  ;; (prog-mode . yas-minor-mode)
  ;; (prog-mode . centered-cursor-mode)
  :config
  (require 'flyspell)
  ;; (require 'flycheck)

  ;; Highlight hex strings in respective color.
  (use-package rainbow-mode
    :ensure t)
  (use-package string-inflection
    :ensure t)

  (use-package reformatter
    :ensure t)

  (defun v/prog-mode-hook-function ()
    (v/vsetq prettify-symbols-alist '(("lambda" . ?λ)
                                      ("->" . ?→)))))
