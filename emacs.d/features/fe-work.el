(run-with-idle-timer
 0.5 nil
 (lambda ()
   ;; Load local elisp.
   (dolist (file (file-expand-wildcards "~/.emacs.d/local/*.el"))
     ;; Not using ar/init--idle-load explicit paths not known.
     (load file))

   ;; Load work elisp.
   (dolist (file (file-expand-wildcards "~/.emacs.d/work/*.el"))
     ;; Not using ar/init--idle-load explicit paths not known.
     (load file))))
