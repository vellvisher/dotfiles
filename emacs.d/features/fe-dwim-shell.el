(use-package dwim-shell-command
  :ensure t
  :commands (v/dwim-shell-command-convert-to-mp4
             v/dwim-shell-command-extract-xip
             v/dwim-shell-command-convert-to-webp)
  :bind (([remap shell-command] . dwim-shell-command)
         :map dired-mode-map
         ([remap dired-do-async-shell-command] . dwim-shell-command)
         ([remap dired-do-shell-command] . dwim-shell-command)
         ([remap dired-smart-shell-command] . dwim-shell-command))
  :config
  (defun v/dwim-shell-command-convert-to-mp4 ()
    "Convert to mov to mp4"
    (interactive)
    (dwim-shell-command-on-marked-files
     "Convert to mov to mp4"
     ;; "ffmpeg -loglevel quiet -stats -y -i <<f>>.MOV -vcodec h264 -acodec copy <<fne>>.mp4"
     ;; Found the encoder via ffmpeg -encoders | grep videotoolbox,
     ;; source https://www.reddit.com/r/ffmpeg/comments/14pqeex/getting_0_gpu_utilization_with_apple_silicons/
     "ffmpeg -i '<<f>>' -map_metadata 0 \
     -c:v hevc_videotoolbox -q:v 35 -preset fast -c:a aac -b:a 128k -tag:v hvc1 '<<fne>>'.mp4"
     :utils "ffmpeg"))
  (defun v/dwim-shell-command-extract-xip ()
    "Extract xip xcode archive"
    (interactive)
    (dwim-shell-command-on-marked-files
     "Extract an xip xcode archive"
     "xip --extract <<f>>"
     :utils "xip"))
  (defun v/dwim-shell-command-convert-to-webp ()
    "Convert to webp"
    (interactive)
    (dwim-shell-command-on-marked-files
     "Convert to webp"
     "cwebp -q 50 <<f>> -o <<fne>>.webp"
     :utils "cwebp")))
