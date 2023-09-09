;;; siren-pdf.el --- jimeh's Emacs Siren: pdf-mode configuration.

;;; Commentary:

;; Basic configuration for pdf-mode.

;;; Code:


(use-package pdf-tools
  :config
  (custom-set-variables
   '(pdf-tools-handle-upgrades t)))
(setq pdf-view-midnight-colors '("#f8f8f2" . "#282a36"))
;; (pdf-view-midnight-minor-mode)
(pdf-tools-install)
(pdf-loader-install)

(provide 'siren-pdf)
;;; siren-pdf.el ends here
