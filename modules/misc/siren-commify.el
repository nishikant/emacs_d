;;; siren-commify.el --- jimeh's Emacs Siren: commify configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for zone.

;;; Code:

(use-package commify)
;; (key-chord-define-global ",," 'commify-toggle)

(setq commify-group-char ",")
(setq commify-decimal-char ".")
(setq commify-group-size 3)
(setq commify-bin-group-size 8)

;; (key-chord-define-global ",," 'commify-toggle)

(provide 'siren-commify)
;;; siren-commify.el ends here
