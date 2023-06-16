(use-package dwim-shell-command
  :ensure t
  :bind (([remap shell-command] . dwim-shell-command)
         :map dired-mode-map
         ([remap dired-do-async-shell-command] . dwim-shell-command)
         ([remap dired-do-shell-command] . dwim-shell-command)
         ([remap dired-smart-shell-command] . dwim-shell-command))
  :config
  (defun v/dwim-shell-command-convert-to-mp4 ()
    "Convert all marked videos to optimized gif(s)."
    (interactive)
    (dwim-shell-command-on-marked-files
     "Convert to mov to mp4"
     ;; "ffmpeg -loglevel quiet -stats -y -i <<f>>.MOV -vcodec h264 -acodec copy <<fne>>.mp4"
     "ffmpeg -i '<<f>>' -vcodec h264 -acodec copy '<<fne>>'.mp4"
     :utils "ffmpeg")))
