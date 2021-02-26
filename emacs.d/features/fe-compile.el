(defun v/compile--history-path ()
  (concat (file-name-as-directory (expand-file-name "~/.emacs.d/")) ".comphist.el"))

(defun v/compile--history-read ()
  (if (not (file-exists-p (v/compile--history-path)))
      (make-hash-table :test 'equal)
    (with-temp-buffer
      (insert-file-contents (v/compile--history-path))
      (read (current-buffer)))))

(defun v/compile--history-write (hashtable)
  (with-temp-buffer
    (prin1 hashtable (current-buffer))
    (write-file (v/compile--history-path) nil)))

(defun v/compile--history-add (command project-root directory)
  (let* ((history (v/compile--history-read)))
    (map-put history command (list project-root directory))
    (v/compile--history-write history)))

(defun v/compile--history-get (command)
  (let* ((history (v/compile--history-read)))
    (map-elt history command)))

(defun v/compile (prefix)
  (interactive "p")
  (if (and (eq prefix 1)
           ;; Check if command invoked via binding.
           (eq (key-binding (this-command-keys)) this-command)
           (buffer-live-p compilation-last-buffer))
      ;; Retry using last compile command.
      (progn
        (set-buffer compilation-last-buffer)
        (revert-buffer t t))
    ;; Compile using environment caching.
    (let* ((command (compilation-read-command compile-command))
           (project-root (projectile-project-root))
           (cache (v/compile--history-get command))
           (cached-root (nth 0 cache))
           (cached-directory (nth 1 cache))
           (potential-directory (when (and cached-directory
                                           (file-exists-p (concat project-root cached-directory)))
                                  (concat project-root cached-directory)))
           ;; Overriding default-directory for compile command.
           (default-directory (or potential-directory default-directory)))
      (setq v/compile--command command)
      (setq v/compile--project-root project-root)
      (setq v/compile--directory (if project-root
                                      (file-relative-name default-directory project-root)
                                    default-directory))
      (compile command))))

(defun v/compile-cache-env (buffer string)
  (when (and (string-match "finished" string)
             (boundp 'v/compile--command)
             (boundp 'v/compile--directory)
             (boundp 'v/compile--project-root))
    (v/compile--history-add v/compile--command
                             v/compile--project-root
                             v/compile--directory)
    (makunbound 'v/compile--command)
    (makunbound 'v/compile--directory)
    (makunbound 'v/compile--project-root)))


(defun v/compile-autoclose (buffer string)
  "Hide successful builds window with BUFFER and STRING."
  (cond ((string-match "finished" string)
         (message "Build finished")
         (when (and (> (count-windows) 1)
                    (get-buffer-window buffer t))
           (run-with-timer 2 nil
                           #'delete-window
                           (get-buffer-window buffer t))))
        (t
         (message "Compilation exited abnormally: %s" string))))

;; Automatically hide successful builds window.
;; Trying out without for a little while.
(setq compilation-finish-functions (list #'v/compile-autoclose #'v/compile-cache-env))
(setq compilation-finish-functions nil)

(use-package compile
  :bind (:map prog-mode-map ("C-c C-c" . v/compile))
  :custom
  (compilation-auto-jump-to-first-error nil))
