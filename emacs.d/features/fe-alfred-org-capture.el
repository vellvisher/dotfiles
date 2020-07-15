; https://cestlaz.github.io/posts/using-emacs-24-capture-2/
 ; Bind Key to: emacsclient -ne "(make-capture-frame)"

 (defadvice org-capture-finalize
     (after delete-capture-frame activate)
   "Advise capture-finalize to close the frame"
   (if (equal "capture" (frame-parameter nil 'name))
       (delete-frame)))

 (defadvice org-capture-destroy
     (after delete-capture-frame activate)
   "Advise capture-destroy to close the frame"
   (if (equal "capture" (frame-parameter nil 'name))
       (delete-frame)))

 (use-package noflet
    :ensure t )
 (defun v/make-capture-frame ()
   "Create a new frame and run org-capture."
   (interactive)
   (make-frame '((name . "capture")))
   (select-frame-by-name "capture")
   (delete-other-windows)
   (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
           (org-capture)))
