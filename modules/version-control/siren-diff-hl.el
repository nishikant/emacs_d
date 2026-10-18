;;; siren-diff-hl.el --- jimeh's Emacs Siren: diff-hl configuration. -*- lexical-binding: t; -*-

;;; Commentary:

;; Basic configuration for diff-hl.

;;; Code:

(require 'siren-magit)

(defgroup siren-diff-hl nil
  "Siren specific tweaks to diff-hl."
  :group 'diff-hl)

(defface siren-diff-hl-insert
  '((default :inherit diff-hl-insert))
  "Face used to highlight inserted lines."
  :group 'siren-diff-hl)

(defface siren-diff-hl-delete
  '((default :inherit diff-hl-delete))
  "Face used to highlight deleted lines."
  :group 'siren-diff-hl)

(defface siren-diff-hl-change
  '((default :inherit diff-hl-change))
  "Face used to highlight changed lines."
  :group 'siren-diff-hl)

(defun siren-diff-hl-fringe-face-from-type (type _pos)
  "Return the Siren diff-hl face for TYPE."
  (intern (format "siren-diff-hl-%s" type)))

(defun siren-diff-hl-fringe-bmp-from-type (type _pos)
  "Return the Siren diff-hl fringe bitmap for TYPE."
  (intern (format "siren-diff-hl-%s" type)))

(defun siren-diff-hl-set-render-mode ()
  "Use the fringe on graphical displays and the margin in terminals."
  (diff-hl-margin-mode
   (if (display-graphic-p)
       -1
     1)))

(use-package diff-hl
  :demand t

  :hook
  ((prog-mode . diff-hl-mode)
   (text-mode . diff-hl-mode)
   (dired-mode . diff-hl-dired-mode)
   (magit-pre-refresh . diff-hl-magit-pre-refresh)
   (magit-post-refresh . diff-hl-magit-post-refresh)
   (desktop-after-read . siren-diff-hl-set-render-mode))

  :custom
  (diff-hl-fringe-bmp-function #'siren-diff-hl-fringe-bmp-from-type)
  (diff-hl-fringe-face-function #'siren-diff-hl-fringe-face-from-type)
  (diff-hl-margin-symbols-alist
   '((insert . "┃")
     (delete . "┃")
     (change . "┃")
     (unknown . "?")
     (ignored . "i")))

  :config
  (siren-diff-hl-set-render-mode)

  (define-fringe-bitmap 'siren-diff-hl-insert
    [#b00000011] nil nil '(center repeated))

  (define-fringe-bitmap 'siren-diff-hl-change
    [#b00000011] nil nil '(center repeated))

  (define-fringe-bitmap 'siren-diff-hl-delete
    [#b00000011] nil nil '(center repeated)))

(provide 'siren-diff-hl)

;;; siren-diff-hl.el ends here
