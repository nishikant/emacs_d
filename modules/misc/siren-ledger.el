;;; siren-ledger.el --- jimeh's Emacs Siren: ledger configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for ledger.

;;; Code:

(use-package ledger-mode
  :ensure t
  :mode ("\\.ledger.gpg\\'" . ledger-mode)
  :config
  (setq ledger-clear-whole-transactions t)
  (setq ledger-post-amount-alignment-column 62)
  (setq ledger-report-auto-sort-date-p t))

(setq ledger-reports '(("bal" "gpg -d -q %(ledger-file) | %(binary) -f - bal")
                       ("reg" "gpg -d -q %(ledger-file) | %(binary) -f - reg")
                       ("payee" "gpg -d -q %(ledger-file) | %(binary) -f - reg @%(payee)")
                       ("account" "gpg -d -q %(ledger-file) | %(binary) -f - reg %(account)")))

(provide 'siren-ledger)
;;; siren-ledger.el ends here
