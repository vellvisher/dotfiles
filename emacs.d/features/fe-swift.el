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
    (add-hook 'before-save-hook #'v/indent-region-or-buffer t t)))