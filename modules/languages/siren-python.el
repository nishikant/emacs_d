;;; siren-golang.el --- jimeh's Emacs Siren: python-mode configuration.

;;; Commentary:

;; Basic configuration for python-mode.

;;; Code:

(require 'siren-dap)
(require 'siren-flycheck)
(require 'siren-lsp)
(require 'siren-prog-mode)
(require 'siren-projectile)
(require 'siren-reformatter)

(setq python-python-command "/opt/homebrew/bin/python3")

(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

(setq-default py-split-windows-on-execute-function 'split-window-horizontally)

(setq python-indent-guess-indent-offset t)
(setq python-indent-guess-indent-offset-verbose nil)
;; python
(add-to-list 'lsp-enabled-clients 'pyright)
(add-to-list 'lsp-enabled-clients 'ruff-lsp)

(use-package python-mode
  :ensure nil
  :after flycheck
  :mode "\\.py\\'"
  :custom
  (python-indent-offset 4)
  (flycheck-python-pycompile-executable "python3.13")
  (python-shell-interpreter "python3.13")
  :hook
  (python-mode . lsp)
  )

(use-package lsp-pyright
  :hook (python-mode . (lambda () (require 'lsp-pyright)))
  :custom
  (lsp-pyright-multi-root nil))


(use-package py-autopep8)
(require 'py-autopep8)
(py-autopep8-mode)
(add-hook 'python-mode-hook 'py-autopep8-mode)

;; to reformat your python buffer enable blacken-mode in relevant python buffers
(use-package blacken)

;; Emacs Ipython Notebook
(use-package ein
  :defer t
  :config
  (setq ein:use-auto-complete t)
  :custom
  (ein:complete-on-dot t)
  (ein:auto-save-on-execute t)
  ;; (ein:auto-black-on-execute t)
  (ein:output-area-inlined-images t) ;; not necessary in older versions
  (ein:slice-image t))

;; Try ein and decide if this is needed
;; (use-package jupyter)

;; Use IPython for REPL
(setq python-shell-completion-native-enable nil)
;; (setq python-shell-interpreter "jupyter-notebook"
;;      python-shell-interpreter-args "console"
;;      python-shell-prompt-detect-failure-warning nil)


(provide 'siren-python)
;;; siren-python.el ends here
