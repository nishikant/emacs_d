;;; siren-sh.el --- Shell / Bash configuration  -*- lexical-binding: nil; -*-

;;; Commentary:
;; Bash & shell configuration with:
;; - bash-ts-mode (Emacs 29+)
;; - Proper indentation
;; - LSP (bash-language-server)
;; - ShellCheck via efm-langserver
;; - shfmt on save

;;; Code:

;; --------------------
;; Mode selection
;; --------------------

;; Prefer bash-ts-mode when available
(when (fboundp 'bash-ts-mode)
  (add-to-list 'major-mode-remap-alist
               '(sh-mode . bash-ts-mode)))

(use-package sh-script
  :ensure nil
  :mode
  ("\\.env\\'"        . sh-mode)
  ("\\.env\\..*\\'"   . sh-mode)
  ("\\.envrc\\'"      . sh-mode)
  ("\\.zsh\\'"        . sh-mode)
  ("\\.zshrc\\'"      . sh-mode)
  ("\\.zshenv\\'"     . sh-mode)
  ("\\.zprofile\\'"   . sh-mode)
  ("\\.zlogin\\'"     . sh-mode)
  ("\\.zlogout\\'"    . sh-mode)
  ("\\.tmux\\'"       . sh-mode)
  ("\\.tmuxsh\\'"     . sh-mode)
  ("\\.tmuxtheme\\'"  . sh-mode)
  ("/etc/zsh/.*\\'"   . sh-mode)

  :general
  (:keymaps 'sh-mode-map
            "RET" #'newline-and-indent)

  :hook
  (sh-mode . siren-sh-common-setup)

  :custom
  ;; Classic sh-mode indentation (used when ts-mode unavailable)
  (sh-basic-offset 2)
  (sh-indentation 2)
  (sh-indent-after-continuation 'always)

  :preface
  (defun siren-sh-common-setup ()
    (setq-local tab-width 2
                indent-tabs-mode nil)))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-enabled-clients 'bash-ls))

;; --------------------
;; Tree-sitter indentation (Emacs 29+)
;; --------------------

(with-eval-after-load 'bash-ts-mode
  (setq bash-ts-mode-indent-offset 2))

;; --------------------
;; LSP: Bash
;; --------------------
(with-eval-after-load 'lsp-mode
  (add-hook 'sh-mode-hook #'siren-sh-maybe-enable-lsp)
  (add-hook 'bash-ts-mode-hook #'siren-sh-maybe-enable-lsp))

(defun siren-sh-maybe-enable-lsp ()
  (when (member sh-shell '(bash sh))
    (lsp-deferred)))

;; Silence noisy warning if a shell buffer does not use LSP
(setq lsp-warn-no-matched-clients nil)

;; --------------------
;; ShellCheck via EFM (add-on diagnostics)
;; --------------------

(with-eval-after-load 'lsp-mode
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
     (make-lsp-client
      :new-connection (lsp-stdio-connection '("efm-langserver"))
      :priority 0
      :activation-fn #'lsp-bash-check-sh-shell
      :server-id 'shellcheck
      :add-on? t))))

;; --------------------
;; Formatting: shfmt
;; --------------------

(use-package shfmt
  :hook
  ((sh-mode bash-ts-mode) . shfmt-on-save-mode)
  :custom
  (shfmt-arguments '("-i" "2" "-ci" "-sr")))

(provide 'siren-sh)
;;; siren-sh.el ends here
