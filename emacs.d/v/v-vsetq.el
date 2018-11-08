;;; v-vsetq.el --- alist support.

;;; Commentary:
;; alist helpers.


;;; Code:

(use-package validate
  :ensure t)

(defalias 'v/vsetq 'validate-setq)

(provide 'v-vsetq)

;;; v-vsetq.el ends here
