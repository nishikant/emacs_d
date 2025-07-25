;;; siren-undo-fu.el --- jimeh's Emacs Siren: undo-fu configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for undo-fu.

;;; Code:

(use-package undo-fu
  :demand
  :general
  ("M--" 'undo-fu-only-undo)
  ("C-/" 'undo-fu-only-undo)
  ("s-z" 'undo-fu-only-undo)
  ("C-S-z" 'undo-fu-only-redo)

  :custom
  (undo-fu-allow-undo-in-region nil)
  (undo-fu-ignore-keyboard-quit t)

  ;; Customize undo limits to ensure lots of history is retained, essentially
  ;; settings limits to the same values as undo-tree does.
  (undo-limit 80000000)
  (undo-strong-limit 120000000)
  (undo-outer-limit 360000000))

(provide 'siren-undo-fu)
;;; siren-undo-fu.el ends here
