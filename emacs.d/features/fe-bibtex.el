;; ivy-bibtex: Ivy-based citation picker for pandoc markdown workflow.
;;
;; Zotero setup:
;;   1. Install Better BibTeX plugin in Zotero.
;;   2. Tools → Better BibTeX → Export Library → BibTeX format, tick "Keep updated".
;;      Export to ~/Zotero/library.bib (global default used below).
;;   3. Per project: export a specific Zotero collection to the project's
;;      references.bib with "Keep updated". The .dir-locals.el in each project
;;      then overrides bibtex-completion-bibliography to use that local file.
;;
;; Usage in a markdown buffer:
;;   C-c b   → open Ivy citation picker → inserts [@citekey]

(use-package ivy-bibtex
  :ensure t
  :bind (
         :map latex-mode-map ("C-c b" . ivy-bibtex)
         :map markdown-mode-map ("C-c b" . ivy-bibtex)
         :map org-mode-map ("C-c b" . ivy-bibtex)
         :map bibtex-mode-map ("C-c b" . ivy-bibtex))
  :config
  ;; Global fallback bibliography (Zotero full-library export).
  (setq bibtex-completion-bibliography '("~/Zotero/library.bib"))

  ;; Insert pandoc-style [@key] in markdown/org; \cite{key} in LaTeX.
  (setq bibtex-completion-format-citation-functions
        '((org-mode      . bibtex-completion-format-citation-org-link-to-PDF)
          (latex-mode    . bibtex-completion-format-citation-cite)
          (markdown-mode . bibtex-completion-format-citation-pandoc-citeproc)
          (default       . bibtex-completion-format-citation-pandoc-citeproc)))

  ;; Don't prompt for page numbers etc. on every insert.
  (setq bibtex-completion-cite-prompt-for-optional-arguments nil)

  (setq ivy-bibtex-default-action 'ivy-bibtex-insert-citation)

  ;; Columns shown in the Ivy picker: author, title, year, type.
  (setq bibtex-completion-display-formats
        '((t . "${author:30} ${title:60} ${year:4} ${=type=:7}"))))
