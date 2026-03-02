(require 'v-vcsetq)

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status)
  :config
  (add-to-list 'magit-no-confirm 'stage-all-changes)
  (v/csetq magit-revision-fill-summary-line 100)
  (v/csetq magit-diff-refine-hunk 'all)

  (fullframe magit-status magit-mode-quit-window))

(use-package git-gutter
  :ensure t
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:handled-backends '(git bzr svn)))

(use-package git-link
  :ensure t
  :custom
  (git-link-use-commit 't)
  :defer 5)

(use-package with-editor
  :ensure t
  :hook ((eshell-mode . with-editor-export-editor)
         (term-exec . with-editor-export-editor)
         (shell-mode . with-editor-export-editor)))


(defun v/git-clone-clipboard-url ()
  "Clone git URL in clipboard asynchronously and open in dired when finished."
  (interactive)
  ;; (cl-assert (string-match-p "^\\(http\\|https\\|ssh\\)://" (current-kill 0)) nil "No URL in clipboard")
  (let* ((url (current-kill 0))
         (download-dir (expand-file-name "~/github/"))
         (project-dir (concat (file-name-as-directory download-dir)
                              (file-name-base url)))
         (default-directory download-dir)
         (command (format "git clone %s" url))
         (buffer (generate-new-buffer (format "*%s*" command)))
         (proc))
    (when (file-exists-p project-dir)
      (if (y-or-n-p (format "%s exists. delete?" (file-name-base url)))
          (delete-directory project-dir t)
        (user-error "Bailed")))
    (switch-to-buffer buffer)
    (setq proc (start-process-shell-command (nth 0 (split-string command)) buffer command))
    (with-current-buffer buffer
      (setq default-directory download-dir)
      (shell-command-save-pos-or-erase)
      (require 'shell)
      (shell-mode)
      (view-mode +1))
    (set-process-sentinel proc (lambda (process state)
                                 (let ((output (with-current-buffer (process-buffer process)
                                                 (buffer-string))))
                                   (kill-buffer (process-buffer process))
                                   (if (= (process-exit-status process) 0)
                                       (progn
                                         (message "finished: %s" command)
                                         (dired project-dir))
                                     (user-error (format "%s\n%s" command output))))))
    (set-process-filter proc #'comint-output-filter)))

(use-package gh
  :ensure t
  :after magit)
(defun v/gh-fetch-topics ()
  "Fetch issues and PRs via gh CLI."
  (let ((json-array-type 'list)
        (json-object-type 'alist)
        result)
    (dolist (type '("issue" "pr"))
      (when-let* ((output (with-temp-buffer
                            (when (zerop (call-process "gh" nil t nil type
                                                       "list"
                                                       "--state" "all"
                                                       "--limit" "500"
                                                       "--json" "number,title,state"))
                              (buffer-string))))
                  ((not (string-empty-p (string-trim output)))))
        (condition-case nil
            (dolist (item (json-read-from-string output))
              (push `((:number . ,(map-elt item 'number))
                      (:title  . ,(map-elt item 'title))
                      (:state  . ,(map-elt item 'state)))
                    result))
          (error nil))))
    (nreverse result)))

(defun v/gh-insert-issue-or-pr-number ()
  (interactive)
  (if-let* ((topics (v/gh-fetch-topics))
            (max-state (seq-max (mapcar (lambda (topic)
                                          (length (map-elt topic :state)))
                                        topics)))
            (fmt (format "%%-%ds  %%s  %%s" max-state))
            (candidates (mapcar (lambda (topic)
                                  (let* ((state (propertize (downcase (map-elt topic :state))
                                                            'face (if (string-equal (downcase (map-elt topic :state))
                                                                                    "open")
                                                                      'success 'error)))
                                         (number (propertize (number-to-string (map-elt topic :number))
                                                             'face 'font-lock-comment-face))
                                         (candidate (format fmt state number (map-elt topic :title))))
                                    (put-text-property 0 1 :number (map-elt topic :number) candidate)
                                    candidate))
                                topics))
            (choice (completing-read "Topic: " candidates nil t)))
      (insert (format "#%s" (get-text-property 0 :number choice)))
    (user-error "No topics found")))
