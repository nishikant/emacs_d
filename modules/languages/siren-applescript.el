;;; siren-applescript.el --- jimeh's Emacs Siren: applescript-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for applescript-mode.

;;; Code:

(require 'siren-prog-mode)

(use-package applescript-mode
  :mode
  "\\.applescript\\'"
  "\\.scpt\\'"

  :hook
  (applescript-mode . siren-applescript-mode-setup)

  :preface
  (defun siren-applescript-mode-setup ()
    (run-hooks 'prog-mode-hook)
    (setq-local tab-width 4)

    (highlight-symbol-mode -1)))

(provide 'siren-applescript)
;;; siren-applescript.el ends here
