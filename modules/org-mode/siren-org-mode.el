;;; siren-org-mode.el --- jimeh's Emacs Siren: org-mode configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for org-mode.

;;; Code:

(require 'siren-display-fill-column)
(require 'siren-display-indentation)
(require 'siren-display-line-numbers)
(require 'siren-smart-shift)
(require 'siren-org-roam)

(use-package org
  :ensure nil
  :general
  (:keymaps 'org-mode-map
            "C-j" 'org-return-indent
            "RET" 'org-return-indent
            "M-{" 'org-promote-subtree
            "M-}" 'org-demote-subtree
            "M-P" 'org-metaup
            "M-N" 'org-metadown
            "C-M-n" 'outline-next-visible-heading
            "C-M-p" 'outline-previous-visible-heading
            "C-c [" 'smart-shift-left
            "C-c ]" 'smart-shift-right
            "C-c n l" 'org-roam-buffer-toggle
            "C-c n f" 'org-roam-node-find
            "C-c n g" 'org-roam-graph
            "C-c n i" 'org-roam-node-insert
            "C-c n c" 'org-roam-capture
            "C-c n j" 'org-roam-dailies-capture-today
            "C-c c" 'org-capture)
  (:keymaps 'org-src-mode-map
            "C-c C-c" 'org-edit-src-exit)

  :hook
  (org-mode . siren-org-mode-setup)

  :custom
  (org-adapt-indentation nil)
  (org-blank-before-new-entry '((heading . auto) (plain-list-item . nil)))
  (org-catch-invisible-edits 'show)
  (org-ctrl-k-protect-subtree t)
  (org-export-backends '(ascii html icalendar latex md))
  (org-export-with-section-numbers nil)
  (org-export-with-sub-superscripts '{})
  (org-hide-leading-stars nil)
  (org-return-follows-link t)
  (org-special-ctrl-a/e t)
  (org-special-ctrl-k t)
  (org-src-fontify-natively t)
  (org-src-preserve-indentation t)
  (org-src-tab-acts-natively t)
  (org-src-window-setup 'current-window)

  (org-directory (if (file-directory-p "~/Documents/org")
                     "~/Documents/org" "~/org"))

  (org-babel-load-languages
   '((awk . t)
     (calc . t)
     (clojure . t)
     (css . t)
     (dot . t)
     (emacs-lisp . t)
     (forth . t)
     (fortran . t)
     (haskell . t)
     (js . t)
     (lisp . t)
     (makefile . t)
     (mermaid . t)
     (org . t)
     (perl . t)
     (plantuml . t)
     (ruby . t)
     (sass . t)
     (scheme . t)
     (shell . t)
     (sql . t)
     (sqlite . t)))

  :preface
  (defun siren-org-mode-setup ()
    (setq fill-column 80
          whitespace-action '(auto-cleanup)
          tab-width 8)

    (setcar (nthcdr 4 org-emphasis-regexp-components) 20)
    (org-set-emph-re 'org-emphasis-regexp-components
                     org-emphasis-regexp-components)

    (auto-fill-mode t)
    (siren-display-fill-column t)
    (siren-display-indentation t)
    (siren-display-line-numbers t)
    (visual-line-mode t)
    (whitespace-mode t))

  :config
  (require 'org-mouse)
  (setq org-id-locations-file
        (expand-file-name ".org-id-locations" org-directory))
  (setq org-log-done 'time)
  (setq org-startup-indented t)

  (setq org-capture-templates
        '(("t" "todo" plain (file buffer-name)
           "* TODO %?\n%U\n" :clock-in t :clock-resume t)

          ("j" "Journal entry" plain
           (file+olp+datetree "~/Documents/org-roam/journal.org")
           "%K - %a\n%i\n%?\n"
           :unnarrowed t)

          ("o" "o3" entry
           (file+olp+datetree buffer-name)
           (file "~/project/emacs/org/capture_templates/o3.org"))))
  )

;; Better Looking Bullets
(use-package org-modern
  :hook ((org-mode                 . org-modern-mode)
         (org-agenda-finalize-hook . org-modern-agenda))
  :custom ((org-modern-todo t)
           (org-modern-table nil)
           (org-modern-variable-pitch nil)
           (org-modern-block-fringe nil))
  :commands (org-modern-mode org-modern-agenda)
  :init (global-org-modern-mode))
(setq org-agenda-files (list "~/Documents/"))
(define-key global-map "\C-cc" 'org-capture)

;; Org Presentations using org-tree-slide

(use-package org-tree-slide
  :custom
  (org-image-actual-width nil))


(straight-use-package '(orgtbl-aggregate :host github
                                         :repo "tbanel/orgaggregate"
                                         :branch "master"))
(straight-use-package '(orgtbl-join :host github
                                         :repo "tbanel/orgtbljoin"
                                         :branch "master"))

(use-package org-table-highlight :ensure t
  :hook (org-mode . org-table-highlight-mode))
(setq org-display-remote-inline-images 'download)
(setq org-startup-with-inline-images t)
(provide 'siren-org-mode)
;;; siren-org-mode.el ends here
