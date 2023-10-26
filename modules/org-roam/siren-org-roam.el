;;; siren-org-roam.el --- gattus Emacs Siren: org-mode configuration.

;;; Commentary:

;; Basic configuration for org-roam, a knowledge management system

;;; Code:

(use-package org-roam
  :custom
  (org-roam-directory (if (file-directory-p "~/Documents/")
                          "~/Documents/"))
  :config
  (org-roam-db-autosync-mode)
  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
        '(
          ("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n"))
          )))
(global-set-key (kbd "C-c n f") 'org-roam-node-find)

(provide 'siren-org-roam)
;;; siren-org-roam.el ends here
