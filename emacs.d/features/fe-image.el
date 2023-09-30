;; https://xenodium.com/emacs-viewing-webp-images/
(use-package image
  :custom
  ;; Enable converting external formats (ie. webp) to internal ones.
  (image-use-external-converter t))
