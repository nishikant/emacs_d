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
  (setq org-roam-dailies-capture-templates '("d" "default" entry
                                             "* %?"
                                             :if-new (file+head "%<%Y-%m-%d>.org"
                                                                "#+title: %<%Y-%m-%d>\n")))
  (setq org-capture-templates
        '(
          ("t" "todo" plain (file buffer-name)
           "* TODO %?\n%U\n" :clock-in t :clock-resume t)
          ("j" "Journal entry" plain (file+olp+datetree "~/Documents/org-roam/journal.org")
           "%K - %a\n%i\n%?\n"
           :unnarrowed t)
          ("o" "o3" entry
           (file+olp+datetree buffer-name)
           (file "~/project/emacs_d/templates/org/o3.org")))))

(provide 'siren-org-roam)
;;; siren-org-roam.el ends here
