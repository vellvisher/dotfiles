(setq delete-by-moving-to-trash t)

;; https://www.emacswiki.org/emacs/SystemTrash
;; See trash-directory' as it requires defining system-move-file-to-trash'.
(defun system-move-file-to-trash (file)
  "Use \"trash\" to move FILE to the system trash."
  (cl-assert (executable-find "trash") nil "'trash' must be installed. Needs \"brew install trash\"")
  (call-process (executable-find "trash") nil 0 nil file))
