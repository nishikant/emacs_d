;;; siren-polymode.el --- jimeh's Emacs Siren: polymode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for polymode.

;;; Code:

(use-package polymode
  :ensure (polymode :host github :repo "polymode/polymode" :branch "master")
  :defer t
  :init
  (add-to-list 'warning-suppress-types '(obsolete)))

(provide 'siren-polymode)
;;; siren-polymode.el ends here
