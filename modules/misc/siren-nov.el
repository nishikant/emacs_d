;;; siren-nov.el --- jimeh's Emacs Siren: nov-xwidget configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for zone.

;;; Code:

(use-package esxml)

(use-package nov
  :mode ("\\.epub\\'" . nov-mode))

(use-package nov-xwidget
  :ensure (:host github
                 :repo "chenyanming/nov-xwidget"
                 :branch "main"
                 :files ("*.el"))
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (define-key nov-mode-map (kbd "o") #'nov-xwidget-view)
  (add-hook 'nov-mode-hook #'nov-xwidget-inject-all-files))

(provide 'siren-nov)
;;; siren-nov.el ends here
