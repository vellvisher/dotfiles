(use-package dwim-shell-command
  :ensure t
  :commands (v/dwim-shell-command-convert-to-mp4
             v/dwim-shell-command-extract-xip
             v/dwim-shell-command-make-swift-package-library
             v/dwim-shell-command-proto-to-swift-proto
             v/dwim-shell-command-convert-markdown-to-org
             v/dwim-shell-command-convert-to-webp
             v/dwim-shell-command-unlock-events
             v/dwim-shell-command-python3-venv-run)
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
     "xip -x <<f>>"
     :extensions "xip"
     :utils "xip"))
  (defun v/dwim-shell-commands-make-swift-package-library ()
    "Create a swift package library"
    (interactive)
    (dwim-shell-command-on-marked-files
     "Create a swift package library"
     "swift package init --type library"
     :utils "swift"))
  (defun v/dwim-shell-command-make-swift-package-executable ()
    "Create a swift package executable"
    (interactive)
    (dwim-shell-command-on-marked-files
     "Create a swift package executable"
     "swift package init --type executable"
     :utils "swift"))
  (defun v/dwim-shell-command-proto-to-swift-proto ()
    "Proto to swift proto compiler"
    (interactive)
    (dwim-shell-command-on-marked-files
     "Proto to swift proto compiler"
     "protoc --swift_out=. --proto_path=. <<f>>"
     :extensions "proto"
     :utils "protoc"))
  (defun v/dwim-shell-command-convert-markdown-to-org ()
    "Convert markdown files to org files"
    (interactive)
    (dwim-shell-command-on-marked-files
     "Convert markdown files to org files"
     "pandoc -f markdown -t org -o <<fne>>.org <<f>>"
     :extensions "md"
     :utils "pandoc"))
  (defun v/dwim-shell-command-convert-to-webp ()
    "Convert to webp"
    (interactive)
    (dwim-shell-command-on-marked-files
     "Convert to webp"
     "cwebp -q 50 <<f>> -o <<fne>>.webp"
     :utils "cwebp"))
  (defun v/dwim-shell-command-unlock-events ()
    "List of mac unlock events"
    (interactive)
    (dwim-shell-command-on-marked-files
     "show unlock events for the mac"
     "/usr/bin/log show --predicate \"eventMessage contains 'UNLOCKED'\" --info --last 3h"
     :utils "log"))
  (defun v/dwim-shell-command-python3-venv-run ()
    "Run with python3 venv, creating it if it doesn't exist"
    (interactive)
    (dwim-shell-command-on-marked-files
     "Run python3 with venv environment"
     "[ -d .venv ] || python3 -m venv .venv && source .venv/bin/activate && python3 <<f>>"
     :extensions "py"
     :utils "python3")))
