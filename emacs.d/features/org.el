(require 'v-vsetq)

(use-package org-web-tools
  :ensure t)

(use-package org
  :bind (("C-c c" . org-capture)
	 ("C-c a" . org-agenda-list)
	 ("C-c l" . org-store-link)
	 :map org-mode-map
	 ("C-c C-l" . org-insert-link))
  :config
  (v/vsetq org-directory "~/beorg")
  (v/vsetq org-default-notes-file (concat org-directory "/inbox.org"))
  (v/vsetq org-agenda-files (make-list 1 org-directory))
  (v/vsetq org-return-follows-link t)
  
  (setq org-capture-templates
      '(("t" "TODO" entry (file "")
         "* TODO %?\nSCHEDULED: %^t"))))
