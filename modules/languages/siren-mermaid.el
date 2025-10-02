;;; siren-mermaid.el --- jimeh's Emacs Siren: mermaid-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for mermaid-mode.

;;; Code:

(require 'siren-prog-mode)

(use-package mermaid-mode
  :mode "\\.mermaid\\'" "\\.mmd\\'"

  :hook
  (mermaid-mode . siren-mermaid-mode-setup)

  :preface
  (defun siren-mermaid-mode-setup ()
    (run-hooks 'prog-mode-hook)))

(use-package ob-mermaid
  :straight '(ob-mermaid :type git :host github :repo "arnm/ob-mermaid"
                         :files (:defaults "*.el" ))

  :after org
  :commands (org-babel-execute:mermaid)
  :init
  (add-to-list 'org-src-lang-modes '("mermaid" . mermaid))
  :config
  ;; Uncomment the following line to use ob-mermaid without the need to
  ;; install mermaid-cli globally (requires Node.js). This will install it
  ;; locally in your `straight-base-dir'.
  ;; (setq ob-mermaid-cli-path (expand-file-name "node_modules/.bin/mmdc" straight-base-dir))
  (setq ob-mermaid-cli-path "mmdc")
  )



(provide 'siren-mermaid)
;;; siren-mermaid.el ends here
