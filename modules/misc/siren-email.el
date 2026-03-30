;;; siren-email.el --- jimeh's Emacs Siren: email configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for email.

;;; Code:

(setq auth-sources '("~/.authinfo.gpg"))
(setq user-full-name "Nishikant Sevalkar")
(setq user-mail-address "gattusevalkar@gmail.com")
(setq gnus-select-method
      '(nnimap "gmail"
               (nnimap-address "imap.gmail.com")
               (nnimap-server-port 993)
               (nnimap-stream ssl)
               (nnimap-fetch-partial-articles "text/")))
(setq gnus-secondary-select-methods nil)
(setq message-send-mail-function 'smtpmail-send-it)
(setq smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-stream-type 'starttls)
(setq gnus-message-archive-group
      "nnimap+gmail:[Google Mail]/Sent Mail")
(setq gnus-draft-group
      "nnimap+gmail:[Google Mail]/Drafts")
(setq gnus-trash-group
      "nnimap+gmail:[Google Mail]/Trash")

(setq nnimap-fetch-partial-articles "text/")
(setq nnimap-expunge-on-close 'never)
(setq gnus-use-cache t)
(setq gnus-cache-directory "~/.emacs.d/gnus-cache")
(setq gnus-asynchronous t)
(setq nnmail-split-methods
      '(("github" "From:.*github.com")
        ("alerts" "Subject:.*alert")
        ("inbox" "")))

(setq gnus-summary-line-format
      "%U%R %(%&user-date;  %-25,25f  %B%s%)\n")

(setq gnus-user-date-format-alist
      '(((gnus-seconds-today) . "Today %H:%M")
        ((+ 86400 (gnus-seconds-today)) . "Yesterday %H:%M")
        (t . "%Y-%m-%d %H:%M")))

(setq gnus-summary-thread-gathering-function
      'gnus-gather-threads-by-references)

(setq gnus-thread-sort-functions
      '(gnus-thread-sort-by-most-recent-date))

(setq gnus-thread-ignore-subject t)

(setq gnus-ignored-newsgroups
      ".*Spam.*\\|.*Trash.*")

(add-hook 'gnus-after-init-hook
          (lambda ()
            (run-with-idle-timer
             300 t
             (lambda ()
               (when (gnus-alive-p)
                 (gnus-group-get-new-news))))))

(provide 'siren-email)
;;; siren-email.el ends here
