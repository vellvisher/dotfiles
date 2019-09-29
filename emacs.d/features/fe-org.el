(require 'v-vsetq)

(use-package org-web-tools
  :ensure t)

(use-package org
  :ensure org-plus-contrib ;; Ensure latest org installed from elpa
  :bind (("C-c c" . org-capture)
         ("C-c l" . org-store-link)
         ("C-c t" . org-set-tags-command)
         ("C-c p" . org-priority)
         :map org-mode-map
         ("C-c C-l" . org-insert-link)
         ("<" . v/org-insert-char-dwim))
  :hook((org-mode . v/org-mode-hook-function))
  :config
  (defun v/org-mode-hook-function ()
    (toggle-truncate-lines 0)
    (org-display-inline-images)
    (v/vsetq show-trailing-whitespace t)
    (v/vsetq org-imenu-depth 4)
    (set-fill-column 1000)
    (flyspell-mode +1))

  (defun v/org-insert-char-dwim ()
    (interactive)
    ;; Display org-insert-structure-template if < inserted at BOL.
    (if (looking-back "^")
        (call-interactively #'org-insert-structure-template)
      (self-insert-command 1)))
  (v/vsetq org-directory "~/beorg")
  (v/vsetq org-default-notes-file (concat org-directory "/inbox.org"))
  (v/vsetq org-agenda-files (-list org-directory "~/GoogleDrive/org"))
  ;; Default priority is 'C'
  (v/vsetq org-default-priority 67)
  (v/vsetq org-return-follows-link t)
  (v/vsetq org-catch-invisible-edits 'error)

  ;; Cleaner outline for org.
  (v/vsetq org-hide-leading-stars t)
  (v/vsetq org-odd-levels-only t)
  (v/vsetq org-ellipsis "…")

  ;; Replace with ivy-reveal.
  (bind-key "C-c C-r" nil org-mode-map)

  (v/vsetq org-enforce-todo-dependencies t)

  (setq org-capture-templates
        '(("t" "TODO" entry (file "")
           "* TODO %?\nSCHEDULED: %^t")
          ("b" "Buy" entry (file "")
           "* TODO Buy %?  :shopping:\nSCHEDULED: %^t")
          ("w" "Work" entry (file "~/GoogleDrive/org/work.org")
           "* TODO %?\nSCHEDULED: %^t"))))

(use-package ob
  :custom (org-confirm-babel-evaluate nil)
  :config
  ;; TODO: Add lazy instantiation.
  (use-package ob-swift
    :ensure t)
  ;; TODO: Add lazy instantiation.
  (use-package ob-kotlin
    :ensure t))

;; TODO: Add lazy instantiation.
;; https://stackoverflow.com/questions/41517257/execute-java-code-block-in-org-mode
;; (require 'ob-java)
;; (add-to-list 'org-babel-load-languages '(java . t))

(use-package org-journal
  :ensure t
  :custom ((org-journal-file-format "%Y%m%d.org")
           (org-journal-dir "~/beorg/journal")
           (org-journal-file-type 'weekly)
           (org-journal-date-format "%a %d %b, %Y"))
  :config
  (v/vsetq org-journal-dir "~/beorg/journal")
  (v/vsetq org-journal-file-type 'weekly)
  (v/vsetq org-journal-date-format "%a %d %b, %Y")
  (v/vsetq org-journal-file-format "%Y%m%d.org"))

(use-package org-agenda
  :hook((org-agenda-mode . v/org-agenda-mode-hook-function))
  ;; Suggestion from:
  ;; https://blog.aaronbieber.com/2016/09/25/agenda-interactions-primer.html
  :bind (("S-SPC" . org-agenda-list))
  :config
  (defun v/org-agenda-mode-hook-function ()
    (hl-line-mode +1)
    (goto-address-mode +1)
    (v/vsetq org-agenda-sticky t)))
