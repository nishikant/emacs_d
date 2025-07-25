;;; siren-undohist.el --- jimeh's Emacs Siren: undohist configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for undohist.

;;; Code:

(use-package undohist
  :demand
  :custom
  (undohist-directory (siren-cache-dir "undohist"))
  (undohist-ignored-files '("COMMIT_EDITMSG"))

  :config
  (undohist-initialize))

(provide 'siren-undohist)
;;; siren-undohist.el ends here
