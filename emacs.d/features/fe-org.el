(require 'v-vsetq)

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
  :hook ((org-mode . prettify-symbols-mode)
         (org-mode . org-indent-mode)
         (org-mode . flyspell-mode)
         (org-mode . v/org-mode-hook-function))
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
    (v/csetq org-use-speed-commands t)
    (set-fill-column 1000)
    (v/vsetq prettify-symbols-alist '(("lambda" . ?λ)
                                      ("->" . ?→))))

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

  ;; org-goto
  ;; (v/vsetq org-goto-interface 'outline-path-completionp)
  ;; (v/vsetq org-outline-path-complete-in-steps nil)

  ;; Cleaner outline for org.
  (v/vsetq org-hide-leading-stars t)
  (v/vsetq org-odd-levels-only t)
  (v/vsetq org-ellipsis "…")

  ;; Replace with ivy-reveal.
  (bind-key "C-c C-r" nil org-mode-map)

  (v/vsetq org-enforce-todo-dependencies t)

  ;; Checks if clipboard has url, converts to org-link then.
  ;; Otherwise, asks for string with prompt.
  (defun v/org-clipboard-link-or-prompt-for-input (prompt)
    (let ((value (if (s-prefix? "http" (current-kill 0))
                         (org-web-tools--org-link-for-url (current-kill 0))
                   (read-string prompt))))
      (format "* TODO %s" value)))

  ;; Prompts for book name or url and returns TODO with proper link.
  (defun v/org-capture-book-template ()
    (v/org-clipboard-link-or-prompt-for-input "Book name or url:"))

  ;; Prompts for movie name or url and returns TODO with proper link.
  (defun v/org-capture-movie-template ()
    (v/org-clipboard-link-or-prompt-for-input "Movie name or url:"))

  ;; Prompts for article name or url and returns TODO with proper link.
  (defun v/org-capture-article-template ()
    (v/org-clipboard-link-or-prompt-for-input "Article name or url:"))

  ;; Prompts for emacs url or function.
  (defun v/org-capture-emacs-template ()
    (v/org-clipboard-link-or-prompt-for-input "Emacs resource:"))

  (setq org-capture-templates
        '(("t" "TODO" entry (file "")
           "* TODO %?\nSCHEDULED: %^t")
          ("s" "Shop" entry (file "")
           "* TODO Buy %?  :shopping:\nSCHEDULED: %^t")
          ("b" "Book" entry (file "~/beorg/books.org")
           (function v/org-capture-book-template))
          ("e" "Emacs resource" entry (file "~/beorg/emacs.org")
           (function v/org-capture-emacs-template))
          ("a" "Article" entry (file "~/beorg/articles.org")
           (function v/org-capture-article-template))
          ("m" "Movies" entry (file "~/beorg/movies.org")
           (function v/org-capture-movie-template))
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
         ("N" . v-org-agenda-next-header)
         ("G" . org-agenda-goto-date))
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
                        (org-agenda-skip-if nil '(scheduled deadline))))))
        ;; Fix "Not allowed in tags-type agenda buffers"
        ;; https://emacs.stackexchange.com/a/26303
        (agenda "")))))
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
    (v/vsetq org-agenda-use-time-grid nil)
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

(use-package org-web-tools
  :after org
  :ensure t)

(use-package org-bullets
  :ensure t
  :after org
  :hook
  (org-mode . org-bullets-mode))
