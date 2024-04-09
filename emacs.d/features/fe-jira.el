(use-package org-jira
  :ensure t
  :defer t
  :init
  (setq jiralib-url "https://wildr.atlassian.net")
  :config
  (setq org-jira-working-dir "~/.org-jira")
  (setq org-jira-entry-mode 'private)
  (setq org-jira-done-states '("Done" "CLOSED"))
  (add-hook 'org-jira-mode-hook 'flyspell-mode)
  (add-to-list 'org-modules 'org-jira))
