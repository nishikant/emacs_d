;;; siren-tree-sitter.el --- jimeh's Emacs Siren: tree-sitter

;;; Commentary:

;; Configuration for tree-sitter

;;; Code:

(use-package tree-sitter
  :hook
  ((css-mode
    go-mode
    js-mode
    json-mode
    lua-mode
    nix-mode
    php-mode
    php-mode
    python-mode
    ruby-mode
    rust-mode
    ;; terraform-mode ;; Disabled due to frequently locking up Emacs for minutes
    typescript-mode
    yaml-mode) . siren-tree-sitter-mode-enable)

  :preface
  (defun siren-tree-sitter-mode-enable ()
    (tree-sitter-mode t)))

(use-package tree-sitter-langs
  :hook
  (tree-sitter-after-on . tree-sitter-hl-mode))

(provide 'siren-tree-sitter)
;;; siren-tree-sitter.el ends here
