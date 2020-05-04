;;; siren-sh.el --- jimeh's Emacs Siren: sh-mode configuration.

;;; Commentary:

;; Basic configuration for sh-mode.

;;; Code:

(use-package sh-script
  :straight (:type built-in)
  :mode
  "\\.tmux\\'"
  "\\.tmuxsh\\'"
  "\\.tmuxtheme\\'"
  "zshenv\\'"
  "zshrc\\'"

  :bind
  (:map sh-mode-map
        ("RET" . newline-and-indent))

  :hook
  (sh-mode . siren-sh-mode-setup)

  :init
  (defun siren-sh-mode-setup ()
    (setq tab-width 2
          sh-basic-offset 2
          sh-indentation 2
          whitespace-action '(auto-cleanup))

    (subword-mode +1)))

(provide 'siren-sh)
;;; siren-sh.el ends here
