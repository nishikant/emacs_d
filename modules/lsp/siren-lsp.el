;;; siren-lsp.el --- jimeh's Emacs Siren: lsp-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for lsp-mode.

;;; Code:

(use-package lsp-mode
  :general
  (:keymaps 'lsp-mode-map
            "C-c C-." 'lsp-rename
            "C-c C-f" 'siren-lsp-manual-format-buffer)

  :commands
  lsp
  lsp-deferred
  lsp-format-buffer-on-save-mode
  lsp-organize-imports-on-save-mode

  :hook
  (lsp-mode . siren-lsp-mode-setup)

  :custom
  (lsp-completion-provider :capf)
  (lsp-completion-show-detail t)
  (lsp-completion-show-kind t)
  (lsp-eldoc-enable-hover t)
  (lsp-eldoc-render-all nil)
  (lsp-enable-file-watchers t)
  (lsp-enable-imenu t)
  (lsp-enable-symbol-highlighting t)
  (lsp-enable-xref t)
  (lsp-headerline-breadcrumb-enable t)
  (lsp-idle-delay 0.4)
  (lsp-inlay-hint-enable nil)
  (lsp-keymap-prefix "M-;")
  (lsp-lens-enable t)
  (lsp-modeline-diagnostics-enable t)
  (lsp-semantic-tokens-apply-modifiers t)
  (lsp-semantic-tokens-enable t)
  (lsp-semantic-tokens-warn-on-missing-face nil)
  (lsp-signature-auto-activate t)
  (lsp-signature-render-documentation t)

  ;; Set read process output to 1MB, instead of default 4KB. As many language
  ;; servers produce output ranging from 800KB to 3MB, leaving it at 4KB affects
  ;; performance. More info here:
  ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
  (read-process-output-max (* 1024 1024))

  :custom-face
  ;; Override the default semhl label face.
  (lsp-face-semhl-label ((t (:inherit font-lock-keyword-face))))

  :preface
  (defun siren-lsp-mode-setup ()
    (setq-local company-idle-delay 0.1
                company-minimum-prefix-length 1))

  (defvar-local siren-lsp-manual-format-buffer-func nil)
  (defun siren-lsp-manual-format-buffer ()
    "Intended for manual formatting triggering, e.g. C-c C-f.

Supports overriding the default formatting function by setting the
`siren-lsp-manual-format-buffer-func' buffer-local variable.

Typically this will be used to perform additional formatting
steps not performed by default via the on-save hook."
    (interactive)
    (if siren-lsp-manual-format-buffer-func
        (apply siren-lsp-manual-format-buffer-func nil)
      (lsp-format-buffer)))

  :config
  ;; Add various directories to lsp-file-watch-ignored-directories.
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]tmp\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.devbox\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]straight\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]elpa\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]elpaca\\'")

  (define-minor-mode lsp-format-buffer-on-save-mode
    "Run lsp-format-buffer as a before-save-hook."
    :lighter " fmt"
    (if lsp-format-buffer-on-save-mode
      (add-hook 'before-save-hook 'lsp-format-buffer t t)
      (remove-hook 'before-save-hook 'lsp-format-buffer t)))

  (define-minor-mode lsp-organize-imports-on-save-mode
    "Run lsp-organize-imports as a before-save-hook."
    :lighter " imp"
    (if lsp-organize-imports-on-save-mode
        (add-hook 'before-save-hook 'lsp-organize-imports t t)
      (remove-hook 'before-save-hook 'lsp-organize-imports t))))

(use-package lsp-ui
  :defer t
  :general
  (:keymaps 'lsp-ui-mode-map
            "C-c C-d" 'lsp-ui-doc-glance
            "C-c d" 'lsp-ui-doc-show
            "M-?" 'lsp-ui-peek-find-references
            "C-c C-j" 'lsp-ui-peek-find-definitions)

  :custom
  (lsp-ui-doc-alignment 'window)
  (lsp-ui-doc-delay 0.2)
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header nil)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-max-height 45)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-show-with-cursor nil)
  (lsp-ui-doc-show-with-mouse nil)
  (lsp-ui-doc-use-webkit nil)
  (lsp-ui-peek-always-show nil)
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover nil))

(use-package lsp-bridge
  :straight '(lsp-bridge :type git :host github :repo "manateelazycat/lsp-bridge"
                         :files (:defaults "*.el" "*.py" "acm" "core" "langserver" "multiserver" "resources")
                         :build (:not compile))
  :init
  (global-lsp-bridge-mode))

(provide 'siren-lsp)
;;; siren-lsp.el ends here
