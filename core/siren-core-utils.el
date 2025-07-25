;;; siren-core-utils.el --- jimeh's Emacs Siren: Core Siren functions and macros.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Core Siren functions macros used a bit all over the place. Some shamelessly
;; ripped from Emacs Prelude.

;;; Code:

(require 'cl-lib)

(defmacro siren-prepend (list-var element)
  "Add ELEMENT to beginning of LIST-VAR, removing duplicates."
  `(setq ,list-var (cons ,element (remove ,element ,list-var))))

(defmacro siren-append (list-var element)
  "Add ELEMENT to end of LIST-VAR, removing duplicates."
  `(setq ,list-var (append (remove ,element ,list-var) (list ,element))))

(defmacro siren-add-before (list-var element needle)
  "Add ELEMENT before NEEDLE in LIST-VAR, without removing duplicates."
  `(let ((pos (cl-position ,needle ,list-var)))
     (if pos
         (setq ,list-var (append (cl-subseq ,list-var 0 pos)
                                 (list ,element)
                                 (cl-subseq ,list-var pos)))
       (setq ,list-var (append ,list-var (list ,element))))))

(defmacro siren-add-after (list-var element needle)
  "Add ELEMENT after NEEDLE in LIST-VAR, without removing duplicates."
  `(let ((pos (cl-position ,needle ,list-var)))
     (if pos
         (setq ,list-var (append (cl-subseq ,list-var 0 (1+ pos))
                                 (list ,element)
                                 (cl-subseq ,list-var (1+ pos))))
       (setq ,list-var (append ,list-var (list ,element))))))

(defmacro siren-ensure-before (list-var element needle)
  "Add ELEMENT before NEEDLE in LIST-VAR, removing duplicates."
  `(let* ((cleaned-list (remove ,element ,list-var))
          (pos (cl-position ,needle cleaned-list)))
     (setq ,list-var
           (if pos
               (append (cl-subseq cleaned-list 0 pos)
                       (list ,element)
                       (cl-subseq cleaned-list pos))
             (append cleaned-list (list ,element))))))

(defmacro siren-ensure-after (list-var element needle)
  "Add ELEMENT after NEEDLE in LIST-VAR, removing duplicates."
  `(let* ((cleaned-list (remove ,element ,list-var))
          (pos (cl-position ,needle cleaned-list)))
     (setq ,list-var
           (if pos
               (append (cl-subseq cleaned-list 0 (1+ pos))
                       (list ,element)
                       (cl-subseq cleaned-list (1+ pos)))
             (append cleaned-list (list ,element))))))

(defmacro siren-replace-value (list-var old-value new-value)
  "Replace all occurrences of OLD-VALUE with NEW-VALUE in LIST-VAR in-place."
  `(cl-loop for item on ,list-var
            if (equal (car item) ,old-value)
            do (setf (car item) ,new-value)))

(defmacro siren-replace-if (list-var predicate new-value)
  "Replace elements in LIST-VAR that match PREDICATE with NEW-VALUE in-place."
  `(cl-loop for item on ,list-var
            if (funcall ,predicate (car item))
            do (setf (car item) ,new-value)))

(defun siren-recursive-add-to-load-path (dir)
  "Add DIR and all its sub-directories to `load-path'."
  (add-to-list 'load-path dir)
  (dolist (f (directory-files dir))
    (let ((name (expand-file-name f dir)))
      (when (and (file-directory-p name)
                 (not (string-prefix-p "." f)))
        (siren-recursive-add-to-load-path name)))))

(defun siren-smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun siren-align-region-to-equals (begin end)
  "Align region (specified with BEGIN and END) to equal signs."
  (interactive "r")
  (align-regexp begin end "\\(\\s-*\\)=" 1 1 ))

(defun siren-align-region-to-opening-brace (begin end)
  "Align region (specified with BEGIN and END) to equal opening brace."
  (interactive "r")
  (align-regexp begin end "\\(\\s-*\\){" 1 1 ))

(defun siren-yank-pop-forwards (arg)
  "Yank pop in reverse."
  (interactive "p")
  (yank-pop (- arg)))

(defun siren-other-window-reverse ()
  "Switch to the previous window."
  (interactive)
  (other-window -1))

(defun siren-rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting.

Borrowed from: http://emacsredux.com/blog/2013/05/04/rename-file-and-buffer/"
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)))))))

(defun siren-ignore-error-wrapper (fn)
  "Funtion return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
  (lexical-let ((fn fn))
    (lambda ()
      (interactive)
      (ignore-errors (funcall fn)))))

;; Shamelessly ripped from textmate.el: https://github.com/defunkt/textmate.el
(defmacro siren-allow-line-as-region-for-function (orig-function)
  `(defun ,(intern (concat (symbol-name orig-function) "-or-line"))
       ()
     ,(format "Like `%s', but acts on the current line if mark is not active."
              orig-function)
     (interactive)
     (if mark-active
         (call-interactively (function ,orig-function))
       (save-excursion
         ;; define a region (temporarily) -- so any C-u prefixes etc. are
         ;; preserved.
         (beginning-of-line)
         (set-mark (point))
         (end-of-line)
         (call-interactively (function ,orig-function))))))

(provide 'siren-core-utils)
;;; siren-core-utils.el ends here
