;; Main use is to have my key bindings have the highest priority
;; https://emacs.stackexchange.com/a/358
;; https://github.com/kaushalmodi/.emacs.d/blob/master/elisp/modi-mode.el

(defvar v-mode-map (make-sparse-keymap)
  "Keymap for `v-mode'.")

(define-key v-mode-map (kbd "M-o") 'other-window)

;;;###autoload
(define-minor-mode v-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-v-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " v-mode"
  :keymap v-mode-map)

;;;###autoload
(define-globalized-minor-mode global-v-mode v-mode v-mode)

;; https://github.com/jwiegley/use-package/blob/master/bind-key.el
;; The keymaps in `emulation-mode-map-alists' take precedence over
;; `minor-mode-map-alist'
(add-to-list 'emulation-mode-map-alists `((v-mode . ,v-mode-map)))

;; Turn off the minor mode in the minibuffer
(defun turn-off-v-mode ()
  "Turn off v-mode."
  (v-mode -1))
(add-hook 'minibuffer-setup-hook #'turn-off-v-mode)

(provide 'v-mode)

;; Minor mode tutorial: http://nullprogram.com/blog/2013/02/06/
