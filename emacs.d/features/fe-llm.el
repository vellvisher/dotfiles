(use-package pcsv
  :ensure t)

(use-package chatgpt-shell
  :ensure t
  :custom
  ((chatgpt-shell-openai-key
    (lambda ()
      (auth-source-pick-first-password :host "api.openai.com")))))

(use-package dall-e-shell
  :ensure t
  :custom
  ((dall-e-shell-openai-key
    (lambda ()
      (auth-source-pick-first-password :host "api.openai.com")))
   (dall-e-shell-image-output-directory	"~/tmp_dall_e")))
