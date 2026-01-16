;;; siren-mermaid.el --- jimeh's Emacs Siren: mermaid-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for mermaid-mode and ob-mermaid.

;;; Code:

(require 'siren-prog-mode)
(require 'siren-org-mode)

(use-package mermaid-mode
  :mode ("\\.mermaid\\'" "\\.mmd\\'")

  :hook
  (mermaid-mode . siren-mermaid-mode-setup)

  :preface
  (defun siren-mermaid-mode-setup ()
    (run-hooks 'prog-mode-hook)))

(use-package ob-mermaid
  :ensure (:host github
                 :repo "arnm/ob-mermaid"
                 :files (:defaults "*.el"))

  :after org
  :commands (org-babel-execute:mermaid)

  :hook
  (org-mode . siren-ob-mermaid-setup)

  :preface
  (defun siren-ob-mermaid-setup ()
    (require 'ob-mermaid))

  :init
  (add-to-list 'org-src-lang-modes '("mermaid" . mermaid))

  :config
  (setq ob-mermaid-cli-path "mmdc"))

(provide 'siren-mermaid)
;;; siren-mermaid.el ends here
