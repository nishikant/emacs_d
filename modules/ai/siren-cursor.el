;;; siren-cursor.el --- jimeh's Emacs Siren: cursor configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for cursor.

;;; Code:

(add-to-list 'exec-path (expand-file-name "~/.local/bin/"))
(setenv "PATH" (concat (expand-file-name "~/.local/bin/") ":" (getenv "PATH")))
(use-package cursor-agent
  :ensure  (:host github
                  :repo "chocoelho/cursor-agent.el"
                  :branch "main"
                  :files ("*.el"))
  :config
  (setq cursor-agent-default-model "gpt-5"))

(provide 'siren-cursor)
;;; siren-cursor.el ends here
