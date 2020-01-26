;;; siren-display-indentation.el --- jimeh's Emacs Siren: indent guides setup

;;; Commentary:

;; Setup for rendering indent guides.

;;; Code:

(require 'siren-highlight-indent-guides)

(defun siren-display-indentation (&optional arg)
  "Activate or deactivate indentation guides.
Optional ARG is passed directly to mode toggle function."
  (highlight-indent-guides-mode (or arg t)))

(provide 'siren-display-indentation)
;;; siren-display-indentation.el ends here
