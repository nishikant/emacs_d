;;; siren-sh.el --- jimeh's Emacs Siren: sh-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for sh-mode.

;;; Code:


(use-package sh-script
  :ensure nil
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
    (setq-local tab-width 2)))

  (use-package lsp-bash
    :ensure nil
    :defer t

    :hook
    (sh-mode . siren-lsp-bash-mode-setup)

    :preface
    (defun siren-lsp-bash-mode-setup ()
      (when (member sh-shell '(bash sh))
        (if (fboundp 'lsp-deferred)
            (lsp-deferred))
        (if (fboundp 'tree-sitter-mode)
            (tree-sitter-mode t))))

    :config
    ;; Create custom lsp-client for shellcheck diagnostics via efm-langserver.
    (when (and (executable-find "efm-langserver")
               (executable-find "shellcheck"))
      (lsp-register-custom-settings
       '(("shellcheck.rootMarkers" [".git/"])
         ("shellcheck.languages"
          ((shellscript . [((lintCommand . "shellcheck -f gcc -x -")
                            (lintStdin . t)
                            (lintSource . "shellcheck")
                            (lintFormats . ["%f:%l:%c: %trror: %m"
                                            "%f:%l:%c: %tarning: %m"
                                            "%f:%l:%c: %tote: %m"]))])))))
      (lsp-register-client
       (make-lsp-client :new-connection (lsp-stdio-connection
                                         '("efm-langserver"))
                        :priority 0
                        :activation-fn #'lsp-bash-check-sh-shell
                        :initialized-fn
                        (lambda (workspace)
                          (with-lsp-workspace workspace
                                              (lsp--set-configuration
                                               (gethash "shellcheck"
                                                        (lsp-configuration-section "shellcheck")))))
                        :server-id 'shellcheck
                        :add-on? t))))

  (use-package shfmt
    :hook
    (sh-mode . shfmt-on-save-mode)
    :custom
    (shfmt-arguments '("-i" "2" "-ci" "-sr")))

  (provide 'siren-sh)
;;; siren-sh.el ends here
