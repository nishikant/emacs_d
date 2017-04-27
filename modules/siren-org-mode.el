;;; siren-org-mode.el --- jimeh's Emacs Siren: org-mode configuration.

;;; Commentary:

;; Basic configuration for org-mode.

;;; Code:

(require 'siren-fci)
(require 'siren-smartparens)

(defun siren-org-mode-defaults ()
  (setq org-export-backends (quote (ascii html icalendar latex md confluence)))
  (setq fill-column 80)
  (linum-mode t)
  (flyspell-mode)
  (fci-mode)
  (smartparens-mode +1)
  (setq whitespace-action (quote (auto-cleanup)))
  (visual-line-mode +1)
  (whitespace-mode +1)

  (let ((map org-mode-map))
    (define-key map (kbd "M-[") 'org-promote-subtree)
    (define-key map (kbd "M-]") 'org-demote-subtree)
    (define-key map (kbd "M-p") 'org-metaup)
    (define-key map (kbd "M-n") 'org-metadown)
    (define-key map (kbd "C-M-n") 'outline-next-visible-heading)
    (define-key map (kbd "C-M-p") 'outline-previous-visible-heading)))

(setq siren-org-mode-hook 'siren-org-mode-defaults)

(add-hook 'org-mode-hook (lambda ()
                           (run-hooks 'siren-org-mode-hook)))

(provide 'siren-org-mode)
;;; siren-org-mode.el ends here
