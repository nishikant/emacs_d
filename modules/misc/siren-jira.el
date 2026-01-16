;;; siren-jira.el --- jimeh's Emacs Siren: jira configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:
;; Basic configuration for org-jira and ejira.

;;; Code:

;;;; org-jira ----------------------------------------------------------

(use-package org-jira
  :config
  (setq jiralib-url "https://monsterconfluence.atlassian.net"
        org-jira-working-dir "~/Documents/jira/"
        org-jira-custom-jqls
        '((:jql "project = \"DEVSESOPS\" AND status NOT IN (Done, Closed)
                 AND createdDate > startOfYear(-1)
                 AND createdDate < endOfYear(-1)
                 ORDER BY key ASC"
           :startIndex
           :limit 100
           :filename "devsesops_last_year")
          (:jql "project = \"DEVSESOPS\" AND status NOT IN (Done, Closed)
                 AND createdDate > startOfYear(-2)
                 AND createdDate < endOfYear(-2)
                 ORDER BY key ASC"
           :startIndex
           :limit 100
           :filename "devsesops_last2_year"))))

(defconst org-jira-progress-issue-flow
  '(("New" . "Approval")
    ("Approval" . "Todo")
    ("Todo" . "In Progress")
    ("In Progress" . "Blocked")
    ("Blocked" . "Todo")
    ("In Progress" . "Under Review")
    ("Under Review" . "Done")
    ("Done" . "Closed")))

;;;; ejira -------------------------------------------------------------

(use-package ejira
  :ensure (:host github
                 :repo "emacsbliss/ejira"
                 :branch "fix_pkg")
  :after org
  :config
  (require 'ejira-agenda)
  (setq jiralib2-url             "https://monsterconfluence.atlassian.net"
        jiralib2-auth            'basic
        jiralib2-user-login-name "nishikant.sevalkar@foundit.ai"
        jiralib2-token           ""
        ejira-org-directory      "~/Documents/jira/"
        ejira-projects           '("DEVSESOPS"))
  ;; Auto-detect sprint / epic fields
  (add-hook 'jiralib2-post-login-hook
            #'ejira-guess-epic-sprint-fields)
  (add-to-list 'org-agenda-files ejira-org-directory)
  (org-add-agenda-custom-command
   '("j" "My JIRA issues"
     ((ejira-jql
       "resolution = unresolved and assignee = currentUser()"
       ((org-agenda-overriding-header "Assigned to me"))))))
  )

(provide 'siren-jira)
;;; siren-jira.el ends here
