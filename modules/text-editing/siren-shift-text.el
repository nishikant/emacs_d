;;; siren-shift-text.el --- jimeh's Emacs Siren: shift-text  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Configuration for shift-text

;;; Code:

(defun siren-shift-right (&optional arg)
  "Shift the line or region to the ARG places to the right.
A place is considered `tab-width' character columns."
  (interactive)
  (let ((deactivate-mark nil)
        (beg (or (and mark-active (region-beginning))
                 (line-beginning-position)))
        (end (or (and mark-active (region-end)) (line-end-position))))
    (indent-rigidly beg end (* (or arg 1) tab-width))))

(defun siren-shift-left (&optional arg)
  "Shift the line or region to the ARG places to the left."
  (interactive)
  (siren-shift-right (* -1 (or arg 1))))

(siren-general-define-key
  "C-c [" 'siren-shift-left
  "C-c ]" 'siren-shift-right
  "M-{" 'siren-shift-left
  "M-}" 'siren-shift-right)

(provide 'siren-shift-text)
;;; siren-shift-text.el ends here
