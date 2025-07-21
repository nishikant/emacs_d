;;; siren-dap.el --- jimeh's Emacs Siren: dap-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for dap-mode.

;;; Code:

(require 'siren-debug-map)
(require 'siren-hydra)

(use-package dap-mode
  :defer t

  :general
  (:keymaps 'siren-debug-map
            "d" 'dap-debug
            "t" 'dap-breakpoint-toggle
            "c" 'dap-breakpoint-condition
            "h" 'dap-breakpoint-hit-condition
            "m" 'dap-breakpoint-log-message
            "l" 'dap-ui-breakpoints-list
            "b" 'dap-ui-breakpoints)

  :custom
  (dap-auto-configure-features '(sessions locals controls tooltip))

  :config
  (dap-auto-configure-mode t)
  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra))))

(straight-use-package '(lsp-java :host github
                                 :repo "emacs-lsp/lsp-java"
                                 :branch "master"))

(add-hook 'java-mode-hook 'lsp)
;; (setq lsp-java-vmargs '("-cp" ".:/Users/gattu/project/java/algs4.jars:/Library/Java/Extensions"))


(setq dap-auto-configure-features '(sessions locals controls tooltip))
;; The modes above are optional

;; enables mouse hover support
(dap-tooltip-mode 1)
;; use tooltips for mouse hover
;; if it is not enabled `dap-mode' will use the minibuffer.
(tooltip-mode 1)
;; displays floating panel with debug buttons
;; requies emacs 26+
(dap-ui-controls-mode 1)
(dap-register-debug-template "Rust::GDB Run Configuration"
                             (list :type "gdb"
                                   :request "launch"
                                   :name "GDB::Run"
                                   :gdbpath "rust-gdb"
                                   :target nil
                                   :cwd nil))

;; JavaRunner
(dap-register-debug-template "JavaRunner"
                             (list :type "java"
                                   :request "launch"
                                   :args ""
                                   :vmArgs "-ea -Dmyapp.instance.name=myapp_1"
                                   :projectName "myapp"
                                   :mainClass "com.domain.AppRunner"
                                   :env '(("DEV" . "1"))))

;; Python template

(dap-register-debug-template "My App"
                             (list :type "python"
                                   :args "-i"
                                   :cwd nil
                                   :env '(("DEBUG" . "1"))
                                   :target-module (expand-file-name "~/src/myapp/.env/bin/myapp")
                                   :request "launch"
                                   :name "My App"))

(provide 'siren-dap)
;;; siren-dap.el ends here
