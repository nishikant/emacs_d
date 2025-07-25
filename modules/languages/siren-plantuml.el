;;; siren-plantuml.el --- jimeh's Emacs Siren: plantuml-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for plantuml-mode.

;;; Code:

(use-package plantuml-mode
  :mode "\\.uml\\'"
  :hook
  (plantuml-mode . siren-plantuml-mode-setup)

  :custom
  (plantuml-default-exec-mode 'executable)

  :preface
  (defun siren-plantuml-mode-setup ()
    (setq-local tab-width 2)))

(provide 'siren-plantuml)
;;; siren-plantuml.el ends here
