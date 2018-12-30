(require 'v-vsetq)


(use-package org-web-tools
  :ensure t)

(use-package org
  :config
  (v/vsetq org-default-notes-file "~/beorg/inbox.org")
  (v/vsetq org-return-follows-link t))
