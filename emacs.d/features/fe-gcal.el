(require 'v-vsetq)

(use-package org-gcal
  :ensure t
  :config
  (v/vsetq org-gcal-client-id "your-id-foo.apps.googleusercontent.com"
           org-gcal-client-secret "your-secret"
           org-gcal-file-alist '(("your-mail@gmail.com" .  "~/schedule.org")
                                 ("another-mail@gmail.com" .  "~/task.org"))))
