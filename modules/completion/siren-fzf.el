;;; siren-fzf.el --- jimeh's Emacs Siren: fzf configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:
;; Basic configuration for fzf / affe.

;;; Code:

(require 'siren-flyspell)

;;;; fzf -------------------------------------------------------------

(use-package fzf
  :defer t
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        fzf/grep-command "grep -nrH"
        fzf/position-bottom t
        fzf/window-height 15))

;;;; affe ------------------------------------------------------------

(defun siren-affe-orderless-regexp-compiler (input _type _ignorecase)
  (setq input (cdr (orderless-compile input)))
  (cons input (apply-partially #'orderless--highlight input t)))

(use-package affe
  :after consult
  :commands (affe-find affe-grep)
  :config
  ;; Ensure consult is fully loaded before touching its APIs
  (consult-customize affe-grep :preview-key "M-.")

  ;; Orderless integration
  (setq affe-regexp-compiler #'siren-affe-orderless-regexp-compiler))

(provide 'siren-fzf)
;;; siren-fzf.el ends here
