(require 'v-vsetq)

(use-package swiper
  :ensure t
  :bind ("M-s" . swiper))

(global-subword-mode 1)

(global-set-key (kbd "M-i") 'imenu)

(v/vsetq next-screen-context-lines 10)

(global-set-key (kbd "M-o") 'other-window)

;; Disable to get used to above binding.
(global-unset-key (kbd "C-x o"))

;; M-a and M-e respect single-spaced sentences.
(v/vsetq sentence-end-double-space nil)

;; From http://endlessparentheses.com/emacs-narrow-or-widen-dwim.html
(defun v/narrow-or-widen-dwim (p)
  "Widen if buffer is narrowed, narrow-dwim otherwise.
Dwim means: region, org-src-block, org-subtree, or defun,
whichever applies first. Narrowing to org-src-block actually
calls `org-edit-src-code'.
With prefix P, don't widen, just narrow even if buffer is
already narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode)
         ;; `org-edit-src-code' is not a real narrowing
         ;; command. Remove this first conditional if you
         ;; don't want it.
         (cond ((ignore-errors (org-edit-src-code))
                (delete-other-windows))
               ((ignore-errors (org-narrow-to-block) t))
               (t (org-narrow-to-subtree))))
        ((derived-mode-p 'latex-mode)
         (LaTeX-narrow-to-environment))
        (t (narrow-to-defun))))

(bind-key "C-x n n" #'v/narrow-or-widen-dwim)

;; Selectively enable for consistency with Mac movement.
(bind-key "s-b" 'backward-word)
(bind-key "s-f" 'forward-word)
