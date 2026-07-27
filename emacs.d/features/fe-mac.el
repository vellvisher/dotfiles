(setq delete-by-moving-to-trash t)

;; https://www.emacswiki.org/emacs/SystemTrash
;; See trash-directory' as it requires defining system-move-file-to-trash'.
(defun system-move-file-to-trash (file)
  "Use \"trash\" to move FILE to the system trash."
  (cl-assert (executable-find "trash") nil "'trash' must be installed. Needs \"brew install trash\"")
  (call-process (executable-find "trash") nil 0 nil file))

(use-package macos
  :vc (:url "https://github.com/xenodium/EmacsMacOSModule")
  :config
  (macos-load-module))

;; Yank the clipboard's HTML flavor as Markdown when present.
(defun v/clipboard-html-as-markdown ()
  "Return the macOS clipboard's HTML flavor converted to Markdown, or nil.
Reads the \"public.html\" pasteboard flavor via AppleScript, decodes the
hex `«data HTML…»' payload and pipes it through pandoc."
  (let* ((script "raw=$(osascript -e 'the clipboard as «class HTML»' 2>/dev/null) || exit 0
hex=$(printf '%s' \"$raw\" | sed -E 's/^«data HTML//; s/»$//')
[ -z \"$hex\" ] && exit 0
printf '%s' \"$hex\" | xxd -r -p | pandoc -f html -t gfm-raw_html --wrap=none | sed 's/\\xc2\\xa0/ /g'")
         (out (string-trim (shell-command-to-string script))))
    (unless (string-empty-p out) out)))

(defun v/yank-or-html-markdown (&optional arg)
  "Yank, converting the clipboard's HTML flavor to Markdown when present.
Falls back to the normal `yank' (honouring ARG) when the clipboard has no
HTML flavor or the conversion yields nothing."
  (interactive "*P")
  (let ((md (v/clipboard-html-as-markdown)))
    (if md
        (progn (push-mark) (insert md))
      (yank arg))))

(global-set-key (kbd "C-S-y") #'v/yank-or-html-markdown)
