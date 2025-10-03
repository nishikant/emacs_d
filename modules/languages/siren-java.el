;;; siren-java.el --- jimeh's Emacs Siren: go-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for go-mode.

;;; Code:


(add-to-list 'lsp-enabled-clients 'jdtls)

(use-package java-snippets)

(setq c-basic-offset 4)

(provide 'siren-java)
;;; siren-java.el ends here
