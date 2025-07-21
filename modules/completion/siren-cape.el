;;; siren-cape.el --- jimeh's Emacs Siren: cape configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for cape. Auto completion on steroids.

;;; Code:

(require 'siren-company)
(require 'siren-yasnippet)

(use-package cape
  :after company
  :hook
  (lsp-completion-mode . siren-cape-capf-lsp-mode-setup)

  :preface
  (defun siren-cape-capf-lsp-mode-setup ()
    ;; Add capf hooks only for lsp-completion-mode
    (siren-cape-capf-add-hooks t))

  (defun siren-cape-capf-add-hooks (&optional local)
    (if local (make-local-variable 'completion-at-point-functions))
    ;; Prepend the custom completion functions in capf contexts
    (siren-prepend completion-at-point-functions 'cape-file)

    ;; Only add yasnippet to capf when company-mode is not active
    (unless (bound-and-true-p company-mode)
      (siren-prepend completion-at-point-functions 'siren-yasnippet-capf)))

  (defun siren-cape-capf-remove-hooks (&optional local)
    ;; Remove capf hooks
    (remove-hook 'completion-at-point-functions 'siren-yasnippet-capf local)
    (remove-hook 'completion-at-point-functions 'cape-file local))

  :init
  (siren-cape-capf-add-hooks))

(provide 'siren-cape)
;;; siren-cape.el ends here
