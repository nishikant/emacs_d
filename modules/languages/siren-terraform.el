;;; siren-terraform.el --- jimeh's Emacs Siren: terraform-mode configuration.

;;; Commentary:

;; Basic configuration for terraform-mode.

;;; Code:

(require 'siren-reformatter)

(use-package terraform-mode
  :hook
  (terraform-mode . siren-terraform-mode-setup)

  :custom
  (terraform-indent-level 2)

  :init
  (defun siren-terraform-mode-setup ()
    (setq tab-width 2)
    (format-all-mode -1)
    (terraform-format-on-save-mode 1))

  :config
  (reformatter-define terraform-format
    :program "terraform"
    :args '("fmt" "-no-color" "-")
    :lighter " TF"))

(use-package company-terraform
  :init
  (with-eval-after-load 'terraform-mode
    (company-terraform-init)))

(provide 'siren-terraform)
;;; siren-terraform.el ends here