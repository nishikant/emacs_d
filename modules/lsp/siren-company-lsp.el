;;; siren-company-lsp.el --- jimeh's Emacs Siren: company-lsp configuration.

;;; Commentary:

;; Basic configuration for company-lsp.

;;; Code:

(require 'siren-company)
(require 'siren-lsp)

(use-package company-lsp
  :commands company-lsp)

(provide 'siren-company-lsp)
;;; siren-company-lsp.el ends here