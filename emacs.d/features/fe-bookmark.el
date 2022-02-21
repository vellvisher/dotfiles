(use-package bookmark
  :init
  (v/csetq bookmark-save-flag 1))

(use-package org-bookmark-heading
  :after org
  :defer 5
  :ensure t)
