;;; siren-relysium.el --- jimeh's Emacs Siren: relysium configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for relysium.

;;; Code:

(use-package relysium
  :ensure (:host github
                 :repo "bluzky/relysium"
                 :branch "main"
                 :files ("*.el"))
  :hook (prog-mode . relysium-prog-mode))

(provide 'siren-relysium)
;;; siren-relysium.el ends here
