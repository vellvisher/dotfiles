(require 'v-vsetq)

(use-package swiper
  :ensure t
  :bind ("M-s" . swiper))

(global-subword-mode 1)

(global-set-key (kbd "M-i") 'imenu)

(v/vsetq next-screen-context-lines 10)
;; M-a and M-e respect single-spaced sentences.
(v/vsetq sentence-end-double-space nil)
