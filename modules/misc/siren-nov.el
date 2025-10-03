;;; siren-nov.el --- jimeh's Emacs Siren: nov-xwidget configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for zone.

;;; Code:

(use-package nov)

(straight-use-package '(nov-xwidget :host github
                                    :repo "chenyanming/nov-xwidget"
                                    :branch "main"
                                    :after nov))

(define-key nov-mode-map (kbd "o") 'nov-xwidget-view)
(add-hook 'nov-mode-hook 'nov-xwidget-inject-all-files)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(provide 'siren-nov)
;;; siren-nov.el ends here
