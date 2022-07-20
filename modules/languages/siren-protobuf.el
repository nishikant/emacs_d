;;; siren-protobuf.el --- jimeh's Emacs Siren: protobuf-mode configuration.

;;; Commentary:

;; Basic configuration for protobuf-mode.

;;; Code:

(require 'siren-clang-format)
(require 'siren-flycheck)
(require 'siren-origami)
(require 'siren-prog-mode)
(require 'siren-reformatter)

(use-package protobuf-mode
  :mode "\\.proto\\'"
  :hook
  (protobuf-mode . siren-protobuf-mode-setup)

  :preface
  (defun siren-protobuf-mode-setup ()
    (run-hooks 'prog-mode-hook)
    (setq-local tab-width 2)

    (c-add-style "siren" '((c-basic-offset . 2)
                           (indent-tabs-mode . nil)) t)

    ;; Lint and format with buf if file is in a buf project.
    (when (flycheck-protobuf-buf-project-root)
      (setq-local flycheck-checker 'protobuf-buf)
      (buf-format-on-save-mode t))

    (subword-mode t)
    (origami-mode t))

  (defun flycheck-protobuf-buf-project-root (&optional _checker)
    "Return the nearest directory holding the buf.yaml configuration."
    (and buffer-file-name
         (locate-dominating-file buffer-file-name "buf.yaml")))

  :init
  (with-eval-after-load 'origami
    (add-to-list 'origami-parser-alist
                 '(protobuf-mode . origami-c-style-parser)))

  :config
  (unbind-key "C-c C-u" 'c-mode-base-map)

  (reformatter-define buf-format
    :program "buf"
    :args `("format" "--path" ,input-file)
    :stdin nil
    :input-file (reformatter-temp-file-in-current-directory))

  (flycheck-define-checker protobuf-buf
    "A protobuf syntax checker using buf.
See URL `https://github.com/bufbuild/buf'."
    :command ("buf" "lint" "--path" source-original)
    :error-patterns
    ((warning line-start (file-name) ":" line ":" column ":" (message) line-end))
    :modes protobuf-mode
    :enabled flycheck-protobuf-buf-project-root
    :working-directory flycheck-protobuf-buf-project-root
    :predicate flycheck-buffer-saved-p)

  (add-to-list 'flycheck-checkers 'protobuf-buf))

(provide 'siren-protobuf)
;;; siren-protobuf.el ends here
