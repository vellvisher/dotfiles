(require 'v-vcsetq)

(add-to-list 'load-path
             (expand-file-name "/opt/homebrew/share/emacs/site-lisp/mu/mu4e/"))

(use-package mu4e
  :bind (("M-m" . v/mu4e-start-and-jump-to-inbox)
         :map mu4e-main-mode-map
         ("i" . v/mu4e-jump-to-inbox))
  :hook ((mu4e-view-mode . goto-address-mode)
         (mu4e-compose-mode . v/mu4e-compose-mode-hook)
         (mu4e-loading-mode . v/mu4e-jump-to-inbox))
  :config
  (defun v/mu4e-start-and-jump-to-inbox ()
    "Jumps directly to the inbox."
    (interactive)
    (mu4e~start)
    (mu4e~headers-jump-to-maildir "/Gmail/Inbox"))
  (defun v/mu4e-jump-to-inbox ()
    "Jumps directly to the inbox."
    (interactive)
    (mu4e~headers-jump-to-maildir "/Gmail/Inbox"))
  (defun v/mu4e-mbsync-and-update-index ()
    "Jumps directly to the inbox."
    (interactive)
    (set-process-sentinel (start-process-shell-command "mbsync" "*mbsync*" "mbsync -Va")
                          (lambda (process state)
                                 (let ((output (with-current-buffer (process-buffer process)
                                                 (buffer-string))))
                                   (if (= (process-exit-status process) 0)
                                       (progn
                                         (message "Process mbsync finished" command)
                                         (mu4e-update-mail-and-index))
                                     (user-error (format "%s\n%s" command output)))))))
  ;; Update mail using 'U' in main view:
  ;; Only update the index, use the brew daemon.
  ;; (setq mu4e-get-mail-command "mbsync -Va")
  (setq mu4e-view-show-addresses t)
  (setq mu4e-attachment-dir (expand-file-name "~/Downloads/"))
  (setq mu4e-maildir "~/mail")
  (setq mu4e-html2text-command "w3m -T text/html") ;; alternatively "textutil -stdin -format html -convert txt -stdout"
  (setq mu4e-user-mail-address-list v-mu4e-user-mail-address-list)
  (setq mu4e-context-policy 'pick-first)
  (setq mu4e-compose-context-policy 'always-ask)
  (setq mu4e-update-interval 30)
  ;; (setq mu4e-index-cleanup nil)      ;; don't do a full cleanup check
  ;; (setq mu4e-index-lazy-check t)    ;; don't consider up-to-date dirs

  ;; don't save message to Sent Messages, Gmail/IMAP takes care of this
  (setq mu4e-sent-messages-behavior 'delete)

  (setq mu4e-change-filenames-when-moving t)

  (auto-fill-mode -1)
  (set-fill-column 1000)

  (add-to-list 'mu4e-bookmarks
               '( :name  "Important (unread)"
                  :query "maildir:/Gmail/[Gmail]/Important and flag:unread"
                  :key   ?u))

  (setq mu4e-maildir-shortcuts
        '( (:maildir "/Gmail/Inbox"     :key  ?i)
           (:maildir "/Gmail/[Gmail]/Important"     :key  ?s)))

  (setq mu4e-display-update-status-in-modeline t)

  (add-to-list 'mu4e-headers-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t)

  (setq mu4e-headers-date-format "%a %d/%m/%y")
  (setq mu4e-headers-time-format "⧖ %H:%M")
  (setq mu4e-headers-fields '((:flags . 6)
                              (:from-or-to . 25)
                              ;; (:recipnum . 2)
                              (:subject . 80)
                              (:human-date . 15)))

  (defun v/mu4e-compose-mode-hook ()
    "Settings for message composition."
    (set-fill-column 1000)
    (flyspell-mode)))

(use-package mu4e-marker-icons
  :ensure t
  :after mu4e
  :init (mu4e-marker-icons-mode 1)
  (setq mu4e-headers-unread-mark    '("u" . "✉️ "))
  (setq mu4e-headers-draft-mark     '("D" . "🚧 "))
  (defcustom v/message-attachment-intent-re
    (regexp-opt '("I attach"
		  "I have included"
		  "I've included"
                  "attached"
                  "attachment"
                  "pdf"))
    "A regex which - if found in the message, and if there is no
attachment - should launch the no-attachment warning.")

  (defcustom v/message-attachment-reminder
    "Are you sure you want to send this message without any attachment? "
    "The default question asked when trying to send a message
containing `v/message-attachment-intent-re' without an
actual attachment.")

  (defun v/message-warn-if-no-attachments ()
    "Ask the user if s?he wants to send the message even though
there are no attachments."
    (when (and (save-excursion
	         (save-restriction
		   (widen)
		   (goto-char (point-min))
		   (re-search-forward v/message-attachment-intent-re nil t)))
	       (not (v/message-attachment-present-p)))
      (unless (y-or-n-p v/message-attachment-reminder)
        (keyboard-quit))))(defcustom v/message-attachment-intent-re
    (regexp-opt '("I attach"
		  "I have included"
		  "I've included"
                  "attached"
                  "attachment"
                  "pdf"))
    "A regex which - if found in the message, and if there is no
attachment - should launch the no-attachment warning.")

  (defcustom v/message-attachment-reminder
    "Are you sure you want to send this message without any attachment? "
    "The default question asked when trying to send a message
containing `v/message-attachment-intent-re' without an
actual attachment.")

  (defun v/message-warn-if-no-attachments ()
    "Ask the user if s?he wants to send the message even though
there are no attachments."
    (when (and (save-excursion
	         (save-restriction
		   (widen)
		   (goto-char (point-min))
		   (re-search-forward v/message-attachment-intent-re nil t)))
	       (not (v/message-attachment-present-p)))
      (unless (y-or-n-p v/message-attachment-reminder)
        (keyboard-quit))))  (setq mu4e-headers-flagged-mark   '("F" . "🚩 "))
  (setq mu4e-headers-new-mark       '("N" . "✨ "))
  (setq mu4e-headers-passed-mark    '("P" . "↪ "))
  (setq mu4e-headers-replied-mark   '("R" . "↩ "))
  (setq mu4e-headers-seen-mark      '("S" . " "))
  (setq mu4e-headers-trashed-mark   '("T" . "🗑️"))
  (setq mu4e-headers-attach-mark    '("a" . "📎 "))
  (setq mu4e-headers-encrypted-mark '("x" . "🔑 "))
  (setq mu4e-headers-signed-mark    '("s" . "🖊 ")))

(use-package smtpmail
  :config
  (setq smtpmail-stream-type 'ssl)
  (setq smtpmail-debug-info t)
  (setq smtpmail-warn-about-unknown-extensions t)
  (setq smtpmail-queue-mail t)
  (setq smtpmail-default-smtp-server nil)
  ;; Created with mu mkdir ~/mail/queue
  ;; Also avoid indexing.
  ;; touch ~/mail/queue/.noindex
  (setq smtpmail-queue-dir "~/mail/queue"))

(use-package message
  :hook ((message-send . v/message-warn-if-no-attachments)
         (message-mode . turn-on-orgtbl))
  :config
  (setq message-send-mail-function 'smtpmail-send-it)
  (v/csetq mail-user-agent 'mu4e-user-agent)
  (v/csetq read-mail-command 'mu4e)
  ;; From http://mbork.pl/2016-02-06_An_attachment_reminder_in_mu4e
  (defun v/message-attachment-present-p ()
    "Return t if an attachment is found in the current message."
    (save-excursion
      (save-restriction
        (widen)
        (goto-char (point-min))
        (when (search-forward "<#part" nil t) t))))

  (defcustom v/message-attachment-intent-re
    (regexp-opt '("I attach"
		  "I have included"
		  "I've included"
                  "attached"
                  "attachment"
                  "pdf"))
    "A regex which - if found in the message, and if there is no
attachment - should launch the no-attachment warning.")

  (defcustom v/message-attachment-reminder
    "Are you sure you want to send this message without any attachment? "
    "The default question asked when trying to send a message
containing `v/message-attachment-intent-re' without an
actual attachment.")

  (defun v/message-warn-if-no-attachments ()
    "Ask the user if s?he wants to send the message even though
there are no attachments."
    (when (and (save-excursion
	         (save-restriction
		   (widen)
		   (goto-char (point-min))
		   (re-search-forward v/message-attachment-intent-re nil t)))
	       (not (v/message-attachment-present-p)))
      (unless (y-or-n-p v/message-attachment-reminder)
        (keyboard-quit))))
  )
