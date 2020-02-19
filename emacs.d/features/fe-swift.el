(require 'v-vsetq)

(use-package swift-mode
  :ensure t
  :mode ("\\.swift\\'" . swift-mode)
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
                                      (list "--configuration" config-file "-m" "format" temp-file-path))
                                  (list "-m" "format" temp-file-path)))
      (add-hook 'swift-mode-hook 'swift-format-on-save-mode))))
