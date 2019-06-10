;;; siren-golang.el --- jimeh's Emacs Siren: go-mode configuration.

;;; Commentary:

;; Basic configuration for go-mode.

;;; Code:

(require 'siren-company)
(require 'siren-flycheck)
(require 'siren-folding)
(require 'siren-lsp)
(require 'siren-projectile)

(use-package go-mode
  :mode "\\.go\\'"
  :interpreter "go"
  :commands go-mode
  :bind (:map go-mode-map
              ("RET" . newline-and-indent)
              ("C-h f" . godoc-at-point)
              ("C-c C-j" . godef-jump)
              ("C-c C-j" . lsp-ui-peek-find-definitions)
              ("C-c C-." . lsp-rename))

  :hook
  (go-mode . siren-go-mode-setup)
  (before-save . gofmt-before-save)

  :init
  (add-to-list 'projectile-globally-ignored-directories "Godeps")
  (add-to-list 'projectile-globally-ignored-directories "vendor/github.com")
  (add-to-list 'projectile-globally-ignored-directories "vendor/gopkg.in")

  (defun siren-go-mode-setup ()
    ;; Prefer goimports to gofmt if installed
    (let ((goimports (executable-find "goimports")))
      (when goimports
        (setq gofmt-command goimports)))

    (setq tab-width 4)
    (whitespace-toggle-options '(tabs))

    (company-mode +1)
    (lsp)
    (highlight-symbol-mode -1)
    (hs-minor-mode 1)
    (hideshowvis-enable)
    (subword-mode +1))

  :config
  (message "loading go-mode")

  (when (memq window-system '(mac ns))
    (exec-path-from-shell-copy-env "GOPATH"))

  (define-key 'help-command (kbd "G") 'godoc)

  ;; Ignore go test -c output files
  (add-to-list 'completion-ignored-extensions ".test"))

(use-package go-dlv
  :commands dlv dlv-current-func)

(use-package gotest
  :after go-mode
  :bind (:map go-mode-map
              ("C-c , a" . go-test-current-project)
              ("C-c , v" . go-test-current-file)
              ("C-c , s" . go-test-current-test)
              ("C-c , c" . go-test-current-coverage)
              ("C-c , b" . go-test-current-benchmark)
              ("C-c , B" . go-test-current-project-benchmarks)
              ("C-c , r" . go-run))

  :custom
  (go-test-verbose t))

(use-package go-projectile
  :after go-mode
  :hook (go-mode . siren-go-projectile-setup)

  :init
  (defun siren-go-projectile-setup ()
    ;; prevent go-projectile from screwing up GOPATH
    (setq go-projectile-switch-gopath 'never)))

(use-package flycheck-golangci-lint
  :hook
  (go-mode . flycheck-golangci-lint-setup))

(use-package go-playground
  :commands go-playground)

(provide 'siren-golang)
;;; siren-golang.el ends here
