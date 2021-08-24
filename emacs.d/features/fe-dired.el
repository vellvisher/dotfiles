(require 'v-vsetq)

(use-package dired-filter
  :ensure t)

(use-package dired-collapse
  :ensure t)

;; Helps when loading files with very long lines
;; https://emacs.stackexchange.com/a/38295
(defun v/dired-find-file-conservatively ()
  (interactive)
  (let ((auto-mode-alist nil))
    (dired-find-file)
    ;; disable costly modes
    (fundamental-mode)
    (setq-local bidi-display-reordering nil)
    (when (boundp 'smartparens-mode)
      (smartparens-mode -1))))
(use-package dired
  :hook ((dired-mode . dired-hide-details-mode)
         (dired-mode . dired-collapse-mode))
  :bind (:map dired-mode-map
              ("i" . dired-hide-details-mode)
              ("M-<return>" . v/dired-find-file-conservatively))
  ;; ("M" . ar/dired-mark-all)
  ;; ("P" . peep-dired)
  :commands (dired-mode)
  ;; ar/find-all-dired-current-dir
  ;; ar/dired-mark-all
  ;; ar/file-find-alternate-parent-dir)
  :init
  :config
  ;; Helps when loading files with very long lines
  ;; https://emacs.stackexchange.com/a/38295
  (defun dired-mkdir ()
    (interactive)
    (dired-create-directory))

  ;; For dired-jump.
  (use-package dired-x)

  ;; Omit ".", ".."
  (v/vsetq dired-omit-mode t)

  (use-package peep-dired
    :ensure t
    :bind (:map dired-mode-map
                ("P" . peep-dired)))

  (use-package ivy-dired-history
    :ensure t)

  ;; (use-package dired-subtree :ensure t
  ;;   :bind (:map dired-mode-map
  ;;               ("<tab>" . dired-subtree-toggle)
  ;;               ("<backtab>" . dired-subtree-cycle)))

  ;; Adding human readable units and sorted by date.
  (v/vsetq dired-listing-switches "-Alhtc")

  ;; Try to guess the target directory for operations.
  (v/vsetq dired-dwim-target t)

  ;; Enable since disabled by default.
  ;; (put 'dired-find-alternate-file 'disabled nil)

  ;; Automatically refresh dired buffers when contents changes.
  (v/vsetq dired-auto-revert-buffer t))

(use-package dired-recent
  :ensure t
  :init
  (dired-recent-mode 1))

(use-package dired-atool
  :ensure t
  :defer 3
  ;; :validate-custom
  ;; (dired-atool-unpack-no-confirm t)
  :bind (:map dired-mode-map
              ("z" . dired-atool-do-unpack-to-current-dir)
              ("Z" . dired-atool-do-pack)))
