(use-package ob
  :custom (org-confirm-babel-evaluate nil)
  :after org
  :config
  ;; TODO: Add lazy instantiation.
  (use-package ob-swift
    :ensure t
    :defer 10)
  ;; TODO: Add lazy instantiation.
  (use-package ob-kotlin
    :ensure t
    :defer 10)
  (use-package ob-async
    :ensure t
    :defer 10)
  (org-babel-do-load-languages
   'org-babel-load-languages '((shell . t)
                               (emacs-lisp . t)
                               (sqlite . t))))

;; TODO: Add lazy instantiation.
;; https://stackoverflow.com/questions/41517257/execute-java-code-block-in-org-mode
;; (require 'ob-java)
;; (add-to-list 'org-babel-load-languages '(java . t))
