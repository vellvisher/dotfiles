(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-mode)
  :defer t
  :config
  (pdf-loader-install)
  (setq pdf-view-use-scaling t))
