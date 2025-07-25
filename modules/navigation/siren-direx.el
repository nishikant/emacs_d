;;; siren-direx.el --- jimeh's Emacs Siren: direx configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for direx.

;;; Code:

(use-package direx
  :general
  ("C-x j" 'direx-project:jump-to-project-root)
  :hook
  (direx-mode . siren-direx-mode-setup)

  :custom
  (direx:closed-icon " + ")
  (direx:open-icon " - ")

  :preface
  (defun siren-direx-mode-setup ()))

(provide 'siren-direx)
;;; siren-direx.el ends here
