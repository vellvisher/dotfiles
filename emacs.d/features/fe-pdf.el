(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-mode)
  :mode ("\\.PDF\\'" . pdf-mode)
  :defer t
  :ensure t
  :config
  (pdf-loader-install)
  (setq pdf-view-use-scaling t))
