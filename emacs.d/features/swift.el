(require 'v-vsetq)

(use-package swift-mode
  :ensure t
  :hook (swift-mode . v/swift-mode-hook)
  :init
  (defun v/swift-mode-hook ()
    "Called when entering `swift-mode'."
    (v/vsetq show-trailing-whitespace t)
    (v/vsetq swift-mode:basic-offset 2)
))
