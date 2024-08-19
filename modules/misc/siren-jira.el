;;; siren-jira.el --- jimeh's Emacs Siren: jira configuration.

;;; Commentary:

;; Basic configuration for org-jira.

;;; Code:
(setq jiralib-url "https://monsterconfluence.atlassian.net")
(setq org-jira-working-dir "~/Documents/jira/")
(setq org-jira-custom-jqls
      '(
        (
         ;; :jql "project=\"DevOps\" AND status not in (Done, Closed) ORDER BY key DESC"
         :jql "project = \"DEVSESOPS\" AND status NOT IN (Done, Closed) and createdDate > startOfYear(-1) AND createdDate < endOfYear(-1) ORDER BY key ASC"
         :startIndex
         :limit 100
         :filename "devsesops_last_year")
        (:jql "project = \"DEVSESOPS\" AND status NOT IN (Done, Closed) and createdDate > startOfYear(-2) AND createdDate < endOfYear(-2) ORDER BY key ASC"
              :startIndex
              :limit 100
              :filename "devsesops_last2_year")))

(use-package org-jira)

(defconst org-jira-progress-issue-flow
'(("New" . "Approval")
   ("Approval" . "Todo")
   ("Todo" . "In Progress")
   ("In Progress" . "Blocked")
   ("Blocked" . "Todo")
   ("In Progress" . "Under Review")
   ("Under Review" . "Done")
   ("Done" . "Closed")))

(straight-use-package '(ejira :host github
                              :repo "nyyManni/ejira"
                              :branch "master"))

  (setq jiralib2-url              "https://monsterconfluence.atlassian.net"
        jiralib2-auth             'basic
        jiralib2-user-login-name  "nishikant.sevalkar@foundit.ai"
        jiralib2-token            ""

        ;; NOTE, this directory needs to be in `org-agenda-files'`
        ejira-org-directory       "~/Documents/jira/"
        ejira-projects            '("DEVSESOPS"))

  ;; Tries to auto-set custom fields by looking into /editmeta
  ;; of an issue and an epic.
  (add-hook 'jiralib2-post-login-hook #'ejira-guess-epic-sprint-fields)

  ;; They can also be set manually if autoconfigure is not used.
  ;; (setq ejira-sprint-field       'customfield_10001
  ;;       ejira-epic-field         'customfield_10002
  ;;       ejira-epic-summary-field 'customfield_10004)

  (require 'ejira-agenda)

  ;; Make the issues visisble in your agenda by adding `ejira-org-directory'
  ;; into your `org-agenda-files'.
  (add-to-list 'org-agenda-files ejira-org-directory)

  ;; Add an agenda view to browse the issues that
  (org-add-agenda-custom-command
   '("j" "My JIRA issues"
     ((ejira-jql "resolution = unresolved and assignee = currentUser()"
                 ((org-agenda-overriding-header "Assigned to me"))))))

(provide 'siren-jira)
;;; siren-jira.el ends here
