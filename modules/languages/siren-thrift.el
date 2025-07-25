;;; siren-thrift.el --- jimeh's Emacs Siren: thrift-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for thrift-mode.

;;; Code:

(require 'siren-prog-mode)

(use-package thrift
  :mode "\\.thrift\\'"
  :hook (thrift-mode . siren-thrift-mode-setup)

  :preface
  (defun siren-thrift-mode-setup ()
    (run-hooks 'prog-mode-hook)
    (setq-local tab-width 2)))

(provide 'siren-thrift)
;;; siren-thrift.el ends here
