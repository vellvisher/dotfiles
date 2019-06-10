(use-package async
  :ensure t
  :config
  (async-bytecomp-package-mode +1))

(use-package validate
  :ensure t
  :config
  (use-package v-vsetq))

(use-package s
  :ensure t)

(use-package dash
  :ensure t)

(use-package drag-stuff
  :config
  (use-package v-drag-stuff))
