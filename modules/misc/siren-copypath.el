;;; siren-copypath.el --- jimeh's Emacs Siren: copypath helpers.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Helper function to reopen buffers.

;;; Code:

(defun siren-copy-filepath-to-clipboard ()
  "Copy the full path of the current buffer's file to the kill ring."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (kill-new filename)
      (message "Copied buffer file path: %s" filename))))

(defun siren-copy-filename-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-name))))
    (when filename
      (kill-new filename))
    (message filename)))

(provide 'siren-copypath)

;;; siren-copypath.el ends here
