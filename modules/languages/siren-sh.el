;;; siren-sh.el --- jimeh's Emacs Siren: sh-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for sh-mode.

;;; Code:


(use-package sh-script
  :straight (:type built-in)
  :mode
  ("\\.env\\'" . sh-mode)              ; .env files
  ("\\.env\\..*\\'" . sh-mode)         ; .env.* files
  ("\\.envrc\\'" . sh-mode)            ; .envrc files
  ("\\.zsh\\'" . sh-mode)              ; .zsh files
  ("\\.zshrc\\'" . sh-mode)            ; .zshrc files
  ("\\.zshenv\\'" . sh-mode)           ; .zshenv files  
  ("\\.zprofile\\'" . sh-mode)         ; .zprofile files
  ("\\.zlogin\\'" . sh-mode)           ; .zlogin files
  ("\\.zlogout\\'" . sh-mode)          ; .zlogout files
  ("\\.tmux\\'" . sh-mode)             ; .tmux files
  ("\\.tmuxsh\\'" . sh-mode)           ; .tmuxsh files
  ("\\.tmuxtheme\\'" . sh-mode)        ; .tmuxtheme files
  ("/etc/zsh/.*\\'" . sh-mode)         ; files in /etc/zsh/ directory

  :general
  (:keymaps 'sh-mode-map
            "RET" 'newline-and-indent)

  :hook
  (sh-mode . lsp-deferred)

  :custom
  (sh-basic-offset 2)
  (sh-indentation 2)
  (sh-indent-after-continuation 'always)

  :preface
  (defun siren-sh-mode-setup ()
    (setq-local tab-width 2))

  (with-eval-after-load 'lsp-mode
    (add-to-list 'lsp-language-id-configuration '(sh-mode . "shellscript"))
    (add-to-list 'lsp-enabled-clients 'bash-language-server)))

(use-package shfmt
  :hook
  (sh-mode . shfmt-on-save-mode)
  :custom
  (shfmt-arguments '("-i" "2" "-ci" "-sr")))

(provide 'siren-sh)
;;; siren-sh.el ends here
