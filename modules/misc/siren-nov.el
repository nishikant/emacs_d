;;; siren-nov.el --- jimeh's Emacs Siren: nov-xwidget configuration.

;;; Commentary:

;; Basic configuration for zone.

;;; Code:

(use-package nov)

(straight-use-package '(nov-xwidget :host github
                                    :repo "chenyanming/nov-xwidget"
                                    :branch "main"))

(define-key nov-mode-map (kbd "o") 'nov-xwidget-view)
(add-hook 'nov-mode-hook 'nov-xwidget-inject-all-files)

(provide 'siren-nov)
;;; siren-nov.el ends here
