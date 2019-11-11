(require 'v-vsetq)

(use-package dired-filter
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
  :hook (dired-mode . dired-hide-details-mode)
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
  ;; For dired-jump.
  ;; (use-package dired-x)

  ;; (use-package peep-dired
  ;;   :ensure t
  ;;   :bind (:map dired-mode-map
  ;;               ("P" . peep-dired)))

  ;; (use-package dired-subtree :ensure t
  ;;   :bind (:map dired-mode-map
  ;;               ("<tab>" . dired-subtree-toggle)
  ;;               ("<backtab>" . dired-subtree-cycle)))

  ;; Adding human readable units and sorted by date.
  ;; (ar/vsetq dired-listing-switches "-Alht") ;

  ;; Try to guess the target directory for operations.
  (v/vsetq dired-dwim-target t)

  ;; Enable since disabled by default.
  ;; (put 'dired-find-alternate-file 'disabled nil)

  ;; Automatically refresh dired buffers when contents changes.
  (v/vsetq dired-auto-revert-buffer t))

  ;; Hide some files
  ;; (setq dired-omit-files "^\\..*$\\|^\\.\\.$")
  ;; (setq dired-omit-mode t)

