(require 'v-vsetq)
(require 'v-drag-stuff)

(setq-default fill-column 80)

(use-package smartparens
  :ensure t
  :init
  (require 'smartparens-config))

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

(use-package drag-stuff
  :ensure t
  :bind (("M-p" . v/drag-stuff-up)
         ("M-n" . v/drag-stuff-down)))

(use-package delsel
  :defer 5
  :config
  ;; Override selection with new text.
  (delete-selection-mode +1))

;; see if replace with easy-kill
(global-set-key "\C-w" 'backward-kill-word)

(global-set-key [remap dabbrev-expand] 'hippie-expand)

(defun insert-british-pound ()
  (insert "£"))
(global-set-key (kbd "s-3") `(lambda()(interactive)(insert-british-pound)))

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

(use-package smartparens
  :ensure t
  :hook ((prog-mode . smartparens-mode)
         (protobuf-mode . smartparens-mode)
         (org-mode . smartparens-mode)
         (tex-mode . smartparens-mode)
         (eshell-mode . smartparens-mode))
  :config
  (defun v/create-newline-and-enter-sexp (&rest _ignored)
    "Open a new brace or bracket expression, with relevant newlines and indent. "
    (newline)
    (indent-according-to-mode)
    (forward-line -1)
    (indent-according-to-mode))

  (sp-local-pair 'prog-mode "{" nil :post-handlers '((v/create-newline-and-enter-sexp "RET")))
  (sp-local-pair 'prog-mode "[" nil :post-handlers '((v/create-newline-and-enter-sexp "RET")))
  (sp-local-pair 'prog-mode "(" nil :post-handlers '((v/create-newline-and-enter-sexp "RET")))

  (defun v/insert-plus-when-region-active (&rest _)
    (region-active-p))

  (sp-local-pair 'org-mode "+" "+" :when '((v/insert-plus-when-region-active))))

(use-package indent
  :bind ("C-M-\\" . v/indent-region-or-buffer)
  :init
  ;; https://emacsredux.com/blog/2013/03/27/indent-region-or-buffer/
  (defun v/indent-buffer ()
    "Indent the currently visited buffer."
    (interactive)
    (indent-region (point-min) (point-max)))

  (defun v/indent-region-or-buffer ()
    "Indent a region if selected, otherwise the whole buffer."
    (interactive)
    (save-excursion
      (if (region-active-p)
          (progn
            (indent-region (region-beginning) (region-end))
            (message "Indented selected region."))
        (progn
          (v/indent-buffer)
          (message "Indented buffer."))))))

(use-package rectangular-region-mode
  :bind ("C-c r" . set-rectangular-region-anchor))

;; Remember history of things across launches (ie. kill ring).
;; From https://www.wisdomandwonder.com/wp-content/uploads/2014/03/C3F.html
(use-package savehist
  :defer 2
  :custom
  (savehist-file "~/.emacs.d/savehist")
  (savehist-save-minibuffer-history t)
  (history-length 20000)
  (savehist-additional-variables
   '(kill-ring
     search-ring
     regexp-search-ring
     last-kbd-macro
     shell-command-history
     compile-history
     ivy-dired-history-variable
     log-edit-comment-ring))
  :config
  (savehist-mode +1))

;; https://www.reddit.com/r/emacs/comments/56qb27/enable_upcasedowncaseregion_but_prevent_accident/
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(defun v/ensure-region-active (func &rest args)
  (when (region-active-p)
    (apply func args)))

(advice-add 'upcase-region :around 'v/ensure-region-active)
(advice-add 'downcase-region :around 'v/ensure-region-active)

(use-package tiny
  ;; Can use this for org-table with dates:
  ;; m\n14||%(date "2023-06-29" (+ x 1))| Day %(1+ x)|||
  :bind ("C-;" . tiny-expand))
