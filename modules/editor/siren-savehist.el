;;; siren-savehist.el --- jimeh's Emacs Siren: savehist configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for savehist.

;;; Code:

(use-package savehist
  :ensure nil

  :custom
  (savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
  (savehist-autosave-interval 60)
  (savehist-file (siren-cache-dir "savehist"))

  :init
  (savehist-mode))

(provide 'siren-savehist)
;;; siren-savehist.el ends here
