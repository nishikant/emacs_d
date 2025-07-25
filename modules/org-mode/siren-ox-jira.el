;;; siren-ox-jira.el --- jimeh's Emacs Siren: ox-jira configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for ox-jira. ox-jira helps exporting text in jira format.

;;; Code:

(require 'siren-org-mode)

(use-package ox-jira
  :defer t

  :hook
  (org-mode . siren-ox-jira-setup)

  :preface
  (defun siren-ox-jira-setup ()
    (require 'ox-jira)))

(provide 'siren-ox-jira)
;;; siren-ox-jira.el ends here
