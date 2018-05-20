;;; siren-css.el --- jimeh's Emacs Siren: css-mode configuration.

;;; Commentary:

;; Basic configuration for css-mode.

;;; Code:

(require 'siren-rainbow)

(use-package css-mode
  :mode "\\.css\\'"
  :hook (css-mode-hook . siren-css-mode-setup)

  :config
  (setq css-indent-offset 2)

  :init
  (defun siren-css-mode-setup ()
    (setq tab-width 2)

    (highlight-indentation-current-column-mode +1)
    (rainbow-mode +1)))

(provide 'siren-css)
;;; siren-css.el ends here