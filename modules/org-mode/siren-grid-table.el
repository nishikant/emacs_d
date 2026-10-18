;;; siren-grid-table.el --- jimeh's Emacs Siren: grid-table configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for grid-table.

;;; Code:

(require 'siren-org-mode)

;; 🚄 One-stop configuration - Recommended!
(use-package grid-table
  :ensure (:host github
                 :repo "yibie/grid-table"
                 :branch "main"
                 :files ("*.el" "plugins/*.el"))
  :load-path "~/project/emacs_d/elpaca/repos/grid-table/plugins"
  :defer t
  :config

  (require 'grid-table)
  (require 'grid-table-plugins)
  (require 'grid-table-csv)      ;; CSV support
  (require 'grid-table-org)      ;; Org integration
  (require 'grid-table-markdown) ;; Markdown integration


  ;; 📁 Custom save directory
  (setq grid-table-default-save-directory "~/Documents/grid_tables/")

  ;; 🖼️ Image display optimization
  (setq grid-table-image-target-char-height 8)
  (setq grid-table-image-max-width-ratio 0.9))

;; 🎯 Load on demand

(provide 'siren-grid-table)
;;; siren-grid-table.el ends here
