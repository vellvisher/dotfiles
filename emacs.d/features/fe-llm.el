(use-package pcsv
  :ensure t)

(use-package chatgpt-shell
  :bind (("C-c C-e" . chatgpt-shell-prompt-compose))
  :ensure t
  :custom
  ((chatgpt-shell-openai-key
    (lambda ()
      (auth-source-pick-first-password :host "api.openai.com")))
   (chatgpt-shell-anthropic-key
    (lambda ()
      (auth-source-pick-first-password :host "api.anthropic.com")))))

(use-package dall-e-shell
  :ensure t
  :bind (:map dall-e-shell-mode-map ("C-c C-v" . v/dall-e-shell-swap-model-version))
  :custom
  ((dall-e-shell-openai-key
    (lambda ()
      (auth-source-pick-first-password :host "api.openai.com")))
   (dall-e-shell-image-output-directory	"~/tmp_dall_e"))
  :config
  ;; From https://platform.openai.com/docs/models/dall-e
  (v/csetq dall-e-shell-model-versions '("dall-e-3" "dall-e-2"))
  (defun v/dall-e-shell-swap-model-version ()
  "Swap model version from `dall-e-shell-model-versions'."
  (interactive)
  (unless (eq major-mode 'dall-e-shell-mode)
    (user-error "Not in a shell"))
  (setq dall-e-shell-model-version
              (completing-read "Model version: "
                                 dall-e-shell-model-versions nil t))))

(use-package acp
  :vc (:url "https://github.com/xenodium/acp.el"))

(use-package agent-shell
  :vc (:url "https://github.com/xenodium/agent-shell")
  :config
  (setq agent-shell-anthropic-authentication
      (agent-shell-anthropic-make-authentication
       :api-key (lambda () (auth-source-pick-first-password :host "api.anthropic.com")))))
