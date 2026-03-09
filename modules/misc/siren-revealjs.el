;;; siren-revealjs.el --- jimeh's Emacs Siren: revealjs-xwidget configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for zone.

;;; Code:


(use-package org-re-reveal
  :ensure (:host git
                 :repo "https://gitlab.com/oer/org-re-reveal.git"
                 :branch "main"
                 :files ("*.el"))
  :config
  (setq org-re-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js@3.7.0")
  (add-to-list 'org-re-reveal-plugin-config '(chalkboard "RevealChalkboard" "plugin/chalkboard/plugin.js"))
  (setq org-re-reveal-revealjs-version "3.7.0"))

(provide 'siren-revealjs)
;;; siren-revealjs.el ends here
