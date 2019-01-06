(require 'v-vsetq)

(use-package org-web-tools
  :ensure t)

(use-package org
  :config
  (v/vsetq org-directory "~/beorg")
  (v/vsetq org-default-notes-file (concat org-directory "/inbox.org"))
  (v/vsetq org-agenda-files (make-list 1 org-directory))
  (v/vsetq org-return-follows-link t))
