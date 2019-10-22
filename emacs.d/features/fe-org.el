(require 'v-vsetq)

(use-package org-web-tools
  :ensure t)

;; Like org-bullets but for priorities.
(use-package org-bullets
  :ensure t
  :hook
  (org-mode . org-bullets-mode))

;; Like org-bullets but for priorities.
(use-package org-fancy-priorities
  :ensure t
  :hook
  (org-mode . org-fancy-priorities-mode)
  :custom
  (org-fancy-priorities-list '("HIGH" "MID" "LOW" "OPTIONAL")))

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
  :custom
  (org-priority-faces '((?A . "#ff2600")
                        (?B . "#ff9200")
                        (?C . "#747474")))
  (org-default-priority ?C)
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
  :bind (("C-c a" . v-pop-to-org-agenda)
         :map org-agenda-mode-map
         ("P" . v-org-agenda-previous-header)
         ("N" . v-org-agenda-next-header))
  :custom
  ((org-agenda-custom-commands
    '(("d" "Daily agenda and all TODOs"
       ((tags "PRIORITY=\"A\""
              ;; Skip if does not have 'TODO'.
              ((org-agenda-skip-function '(or (v-org-skip-category-not-inbox)
                                              (org-agenda-skip-entry-if 'nottodo 'todo)))
               (org-agenda-overriding-header "High-priority unfinished tasks:")))
        (agenda "" ((org-agenda-span 1)))
        (alltodo ""
                 ((org-agenda-overriding-header "Unscheduled:")
                  (org-agenda-skip-function
                   '(or (v-org-skip-category-not-inbox)
                        (org-agenda-skip-entry-if 'todo '("DONE" "OBSOLETE" "CANCELLED"))
                        (org-agenda-skip-if nil '(scheduled deadline))))))))))
   (org-agenda-compact-blocks t))

  :config
  (defun v-org-skip-category-not-inbox ()
    "Skip an agenda entry if it has a CATEGORY property not equal to \"inbox\"."
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (if (string= (org-entry-get nil "CATEGORY") "inbox")
          nil
        subtree-end)))
  (defun v-pop-to-org-agenda (&optional split)
    "Visit the org agenda, in the current window or a SPLIT."
    (interactive "P")
    (org-agenda nil "d"))
  (defun v/org-agenda-mode-hook-function ()
    (hl-line-mode +1)
    (goto-address-mode +1)
    (v/vsetq org-agenda-sticky nil))
  (defun v-org-agenda-next-header ()
    "Jump to the next header in an agenda series."
    (interactive)
    (v--org-agenda-goto-header))

  (defun v-org-agenda-previous-header ()
    "Jump to the previous header in an agenda series."
    (interactive)
    (v--org-agenda-goto-header t))

  (defun v--org-agenda-goto-header (&optional backwards)
    "Find the next agenda series header forwards or BACKWARDS."
    (let ((pos (save-excursion
                 (goto-char (if backwards
                                (line-beginning-position)
                              (line-end-position)))
                 (let* ((find-func (if backwards
                                       'previous-single-property-change
                                     'next-single-property-change))
                        (end-func (if backwards
                                      'max
                                    'min))
                        (all-pos-raw (list (funcall find-func (point) 'org-agenda-structural-header)
                                           (funcall find-func (point) 'org-agenda-date-header)))
                        (all-pos (cl-remove-if-not 'numberp all-pos-raw))
                        (prop-pos (if all-pos (apply end-func all-pos) nil)))
                   prop-pos))))
      (if pos (goto-char pos))
      (if backwards (goto-char (line-beginning-position))))))
