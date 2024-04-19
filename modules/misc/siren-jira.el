;;; siren-jira.el --- jimeh's Emacs Siren: jira configuration.

;;; Commentary:

;; Basic configuration for org-jira.

;;; Code:
(setq jiralib-url "https://monsterconfluence.atlassian.net")
(setq org-jira-custom-jqls
      '(
        (
         ;; :jql "project=\"DevOps\" AND status not in (Done, Closed) ORDER BY key DESC"
         :jql "project = \"DEVSESOPS\" AND status NOT IN (Done, Closed) and createdDate > startOfYear(-1) AND createdDate < endOfYear(-1) ORDER BY key ASC"
         :startIndex
         :limit 10
         :filename "foundit_jira")
        ))

(use-package org-jira)


(provide 'siren-jira)
;;; siren-jira.el ends here
