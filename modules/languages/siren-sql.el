;;; siren-sql.el --- jimeh's Emacs Siren: sql-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for sql-mode.

;;; Code:

(use-package sql-mode
  :straight (:type built-in)
  :mode "\\.sql\\'"
  :hook (sql-mode . siren-sql-mode-setup)

  :preface
  (defun siren-sql-mode-setup ()
    (setq-local tab-width 2)))

(use-package lsp-sqls
  :straight lsp-mode

  :hook
  (sql-mode . lsp-deferred)

  :custom
  (lsp-sqls-connections
   '(((driver . "mysql") (dataSourceName . "root@tcp(localhost:3306)/"))
     ((driver . "postgresql") (dataSourceName . "host=127.0.0.1 port=5432 user=postgres password=postgres dbname=postgres sslmode=disable"))
     )))

(use-package sqlformat
  :hook
  (sql-mode . sqlformat-on-save-mode)

  :custom
  (sqlformat-args '("-g"))
  (sqlformat-command 'pgformatter))

(add-to-list 'lsp-enabled-clients 'sql-ls)
(add-to-list 'lsp-enabled-clients 'sql-language-server)
(provide 'siren-sql)
;;; siren-sql.el ends here
