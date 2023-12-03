;;; fe-swift.el --- Swift mode configuration
;;; Commentary:
;; This file contains the setup for Swift mode.
;;; Code:

(require 'v-vsetq)
(use-package flycheck
  :ensure t
  :defer 10
  :config
  ;; Overrid to C-c f prefix because C-c ! interferes with org-mode inactive
  ;; timestamp.
  (define-key flycheck-mode-map flycheck-keymap-prefix nil)
  (setq flycheck-keymap-prefix (kbd "C-c f"))
  (define-key flycheck-mode-map flycheck-keymap-prefix
    flycheck-command-map)

  (global-flycheck-mode))

(use-package flycheck-swift
  :ensure t
  :after flycheck)

(use-package swift-mode
  :ensure t
  :mode ("\\.swift\\'" . swift-mode)
  :after reformatter
  :hook (swift-mode . v/swift-mode-hook)
  :init
  (defun v/swift-mode-hook ()
    "Called when entering `swift-mode'."
    (v/vsetq swift-mode:basic-offset 2)
    (v/vsetq fill-column 100)

    ;; Need to enable/disable to pickup fill-column value
    ;; since whitespace-mode gets loaded before swift-mode.
    (whitespace-mode -1)
    (whitespace-mode +1)

    (flycheck-swift-setup)

    :config
    (when (require 'reformatter nil 'noerror)
      (reformatter-define swift-format
                          :program "swift-format"
                          :args (let ((buffer (current-buffer))
                                      (config-file (locate-dominating-file (buffer-file-name)
                                                                           ".swift-format.json"))
                                      (temp-file-path (make-temp-file "swift-format-")))
                                  (with-temp-file temp-file-path
                                    (insert-buffer buffer))
                                  (if config-file
                                      (list "--configuration" config-file temp-file-path))
                                  (list temp-file-path)))
      (add-hook 'swift-mode-hook #'(lambda () (swift-format-on-save-mode 1))))))
;;; fe-swift.el ends here
