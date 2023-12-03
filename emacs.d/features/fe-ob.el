(require 'v-vsetq)

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
  (use-package ob-java
    :defer 10)
  (use-package ob-js
    :defer 10)
  (org-babel-do-load-languages
   'org-babel-load-languages '((shell . t)
                               (sqlite . t)
                               (emacs-lisp . t)
                               (sqlite . t)
                               (java . t)
                               (js . t)
                               (python . t))))

;; (v/vsetq org-babel-default-header-args:java '((:classname  . "Test")))
