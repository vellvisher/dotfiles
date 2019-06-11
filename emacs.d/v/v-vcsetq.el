;;; v-vcsetq.el --- alist support.

;;; Commentary:
;; alist helpers.


;;; Code:


;; https://oremacs.com/2015/01/17/setting-up-ediff
;; Macro for setting custom variables.
;; Similar to custom-set-variables, but more like setq.

(defmacro v/csetq (variable value)
  `(funcall (or (get ',variable 'custom-set)
                'set-default) ',variable ,value))

(provide 'v-vcsetq)

;;; v-vcsetq.el ends here
