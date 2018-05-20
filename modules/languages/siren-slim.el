;;; siren-slim.el --- jimeh's Emacs Siren: slim-mode configuration.

;;; Commentary:

;; Basic configuration for slim-mode.

;;; Code:

(require 'siren-highlight-indentation)

(use-package slim-mode
  :mode "\\.slim\\'"
  :hook (slim-mode . siren-slim-mode-hook)

  :init
  (defun siren-slim-mode-setup ()
    (highlight-indentation-current-column-mode)))

(provide 'siren-slim)
;;; siren-slim.el ends here
