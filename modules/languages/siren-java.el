;;; siren-java.el --- jimeh's Emacs Siren: go-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for go-mode.

;;; Code:

(use-package lsp-java
  :ensure t
  :after lsp
  :config
  ;; Optional: set JDTLS install location
  ;; (setq lsp-java-server-install-dir "~/.emacs.d/.cache/lsp/eclipse.jdt.ls")
  )

(use-package java-snippets
  :ensure t)

(setq c-basic-offset 4)

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-enabled-clients 'jdtls))

(add-hook 'java-mode-hook #'lsp)
(add-hook 'lsp-mode-hook #'lsp-ui-mode)

;; (dap-mode 1)
;; (dap-ui-mode 1)

(setq lsp-lens-enable t)

(provide 'siren-java)
;;; siren-java.el ends here
