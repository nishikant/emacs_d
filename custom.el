;; -*- lexical-binding: t; -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-fold-catch-invisible-edits 'show nil nil "Customized with use-package org")
 '(safe-local-variable-values
   '((eval progn
           (setq-local org-roam-directory
                       (locate-dominating-file default-directory
                                               ".dir-locals.el"))
           (setq-local org-roam-db-location
                       (concat org-roam-directory "org-roam.db")))
     (lsp-solargraph-use-bundler . t) (fill-column . 120))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
