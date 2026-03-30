;;; siren-org-roam.el --- gattus Emacs Siren: org-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for org-roam, a knowledge management system

;;; Code:

(use-package org-roam
    :custom
    (org-roam-directory "~/Documents/")
    :config
    (setq org-roam-db-location
        (concat org-roam-directory "org-roam.db"))

    (org-roam-db-autosync-mode)

    (setq org-roam-dailies-directory "daily/")
    (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n"))))

    ;; Safe override per project
    (defun my/org-roam-setup ()
    (let ((dir (locate-dominating-file default-directory ".dir-locals.el")))
      (when dir
        (setq-local org-roam-directory dir)
        (setq-local org-roam-db-location (concat dir "org-roam.db")))))

    (add-hook 'find-file-hook #'my/org-roam-setup))

(global-set-key (kbd "C-c n f") 'org-roam-node-find)

(provide 'siren-org-roam)
;;; siren-org-roam.el ends here
