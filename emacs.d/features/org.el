(require 'v-vsetq)

(use-package org-web-tools
  :ensure t)

(use-package org
  :bind (("C-c c" . org-capture)
         ("C-c a" . org-agenda-list)
         ("C-c l" . org-store-link)
         :map org-mode-map
         ("C-c C-l" . org-insert-link))
  :hook((org-mode . v/org-mode-hook-function))
  :hook((org-agenda-mode . v/org-agenda-mode-hook-function))
  :config
  (defun v/org-mode-hook-function ()
    (toggle-truncate-lines 0)
    (org-display-inline-images)
    (v/vsetq show-trailing-whitespace t)
    (set-fill-column 1000)
    (flyspell-mode +1))

  (defun v/org-agenda-mode-hook-function ()
    (hl-line-mode +1)
    (v/vsetq org-agenda-sticky t))
  (v/vsetq org-directory "~/beorg")
  (v/vsetq org-default-notes-file (concat org-directory "/inbox.org"))
  (v/vsetq org-agenda-files (-list org-directory "~/GoogleDrive/org"))
  ;; Default priority is 'C'
  (v/vsetq org-default-priority 67)
  (v/vsetq org-return-follows-link t)
  (v/vsetq org-catch-invisible-edits 'error)

  (setq org-capture-templates
        '(("t" "TODO" entry (file "")
           "* TODO %?\nSCHEDULED: %^t")
          ("b" "Buy" entry (file "")
           "* TODO Buy %?  :shopping:\nSCHEDULED: %^t")
          ("w" "Work" entry (file "~/GoogleDrive/org/work.org")
           "* TODO %?\nSCHEDULED: %^t"))))

(use-package ob
  :config
  (use-package ob-swift
    :ensure t))
