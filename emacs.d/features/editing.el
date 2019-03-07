(require 'v-vsetq)

;; Show keystrokes earlier (ie. C-x)
(v/vsetq echo-keystrokes 0.1)

;; No need to keep duplicates in prompt history.
(v/vsetq history-delete-duplicates t)

;; Always use spaces.
(setq-default indent-tabs-mode nil)

(use-package simple
  :config
  (v/vsetq kill-ring-max 1000))

(use-package expand-region
  :ensure t
  :bind ("C-c w" . er/expand-region))

(use-package hungry-delete
  :ensure t
  :config (global-hungry-delete-mode))

;; Multiple cursors overrides uses this.
(use-package region-bindings-mode
  :ensure t
  :defer 2
  :config
  (region-bindings-mode-enable))

(use-package multiple-cursors :ensure t
  :after region-bindings-mode
  :init
  (global-unset-key (kbd "M-<down-mouse-1>"))
  :bind (("C-c n" . mc/mark-more-like-this-extended)
         ("M-1" . mc/mark-next-like-this)
         ("M-!" . mc/unmark-next-like-this)
         ("M-2" . mc/mark-previous-like-this)
         ("M-@" . mc/unmark-previous-like-this)
         ("M-<mouse-1>" . mc/add-cursor-on-click))
  :bind (:map region-bindings-mode-map
              ("a" . mc/mark-all-like-this)
              ("p" . mc/mark-previous-like-this)
              ("n" . mc/mark-next-like-this)
              ("P" . mc/unmark-previous-like-this)
              ("N" . mc/unmark-next-like-this)
              ("m" . mc/mark-more-like-this-extended)
              ("h" . mc-hide-unmatched-lines-mode)
              ("\\" . mc/vertical-align-with-space)
              ("#" . mc/insert-numbers) ; use num prefix to set the starting number
              ("^" . mc/edit-beginnings-of-lines)
              ("$" . mc/edit-ends-of-lines)))

(use-package drag-stuff
  :ensure t
  :bind (("M-p" . v/drag-stuff-up)
         ("M-n" . v/drag-stuff-down)))

;; org-metaup/down in org-mode
(defun v/drag-stuff-down (arg)
  (interactive "p")
  "Drag stuff ARG lines down."
  (if (eq major-mode 'org-mode)
      (org-metadown)
    (drag-stuff-down arg)))

;; org-metaup/down in org-mode
(defun v/drag-stuff-up (arg)
  (interactive "p")
  "Drag stuff ARG lines up."
  (if (eq major-mode 'org-mode)
      (org-metaup)
    (drag-stuff-up arg)))

(use-package delsel
  :defer 5
  :config
  ;; Override selection with new text.
  (delete-selection-mode +1))

;; see if replace with easy-kill
(global-set-key "\C-w" 'backward-kill-word)

(global-set-key [remap dabbrev-expand] 'hippie-expand)

(use-package region-state
  :ensure t
  :defer 2
  :config
  (region-state-mode +1))

(use-package whitespace
  :defer 5
  ;; Automatically remove whitespace on saving.
  :hook ((before-save . whitespace-cleanup)
         (prog-mode . whitespace-mode))
  :config
  ;; When nil, fill-column is used instead.
  (v/vsetq whitespace-line-column nil)
  ;; Highlight empty lines, TABs, blanks at beginning/end, lines
  ;; longer than fill-column, and trailing blanks.
  (v/vsetq whitespace-style '(face empty tabs lines-tail trailing))
  (v/vsetq show-trailing-whitespace t)
  (set-face-attribute 'whitespace-line nil
                      :foreground "DarkOrange1"
                      :background nil))
