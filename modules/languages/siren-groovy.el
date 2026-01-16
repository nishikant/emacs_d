;;; siren-groovy.el --- jimeh's Emacs Siren: groovy-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for groovy-mode.

;;; Code:

(use-package groovy-mode
  :mode "\\.groovy\\'"
  :hook
  (groovy-mode . siren-groovy-mode-setup)

  :preface
  (defun siren-groovy-mode-setup ()
    (setq-local groovy-highlight-assignments t
                groovy-indent-offset 4
                tab-width 4)))

;; Jenkins
(use-package jenkins)
;; groovy-mode

(setq-default groovy-mode 1)
;; enable when working on jenkins shared lib
;;  (add-hook 'groovy-mode-hook 'git-auto-commit-mode)

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-enabled-clients 'groovy-ls))

(setq lsp-groovy-server-file "~/projects/groovy-language-server/build/libs/groovy-language-server-all.jar")
(add-hook 'groovy-mode-hook #'lsp-deferred)
;; (add-hook 'groovy-mode-hook #'lsp-groovy-enable)

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

(with-eval-after-load 'lsp-treemacs
  (autoload 'lsp-treemacs-errors-list "lsp-treemacs" nil t))


;; Git autocommit used for groovy
(use-package git-auto-commit-mode)

(provide 'siren-groovy)
;;; siren-groovy.el ends here
