;;; -*- lexical-binding: t; -*-
(require 'v-vsetq)

(use-package flyspell
  :bind (:map
         flyspell-mode-map
         ("C-M-i" . flyspell-correct-wrapper))
  :config
  (use-package flyspell-correct-ivy
    :ensure t
    :init
    ;; Based on http://endlessparentheses.com/ispell-and-abbrev-the-perfect-auto-correct.html
    (defun v/flyspell-correct-ivy-then-abbrev (candidates mispelled-word)
      (let ((selection (flyspell-correct-ivy candidates mispelled-word)))
        (unless (consp selection)
          (define-abbrev global-abbrev-table mispelled-word selection))
        selection)))
    ;; :validate-custom (flyspell-correct-interface
    ;; #'v/flyspell-correct-ivy-then-abbrev)q)

  (use-package abbrev
    ;; :validate-custom
    ;; (abbrev-file-name "~/stuff/active/code/dots/emacs/abbrev_defs")
    ;; (save-abbrevs 'silently)
    :config
    (setq-default abbrev-mode t))

  (use-package ispell
    :config
    ;; http://blog.binchen.org/posts/what-s-the-best-spell-check-set-up-in-emacs.html
    (cond
     ;; if hunspell NOT installed, fallback to aspell
     ((executable-find "hunspell")
      ;; In addition to "brew install hunspell" download dicts to
      ;; ~/Library/Spelling/
      ;; https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_GB.aff
      ;; https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_GB.dic
      (v/csetq  "hunspell")
      (v/csetq ispell-local-dictionary "en_GB")
      (v/csetq ispell-local-dictionary-alist
            '(("en_GB" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_GB") nil utf-8))))
     ((executable-find "aspell")
      (v/csetq ispell-program-name "aspell")
      (v/csetq ispell-extra-args '("--sug-mode=ultra" "--lang=en_GB")))
     (t
      (error "No speller installed")))))

(use-package mw-thesaurus
  :ensure t
  :defer 20
  :commands mw-thesaurus-lookup-at-point)

(use-package auto-dictionary
  :commands adict-change-dictionary
  :ensure t
  :defer 5
  :hook (message-mode . auto-dictionary-mode))
