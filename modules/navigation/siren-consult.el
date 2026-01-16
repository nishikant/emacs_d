;;; siren-consult.el --- jimeh's Emacs Siren: consult configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:
;; Basic configuration for consult.

;;; Code:

(eval-when-compile
  (require 'cl-lib))

(use-package consult
  :defer t
  :general
  ("C-t"     'siren-consult-imenu)
  ("C-x b"   'consult-buffer)
  ("C-c b"   'consult-project-buffer)
  ("M-g M-g" 'consult-goto-line)

  :custom
  (consult-preview-max-count 10)

  :preface
  (defun siren-consult-imenu ()
    "Intelligently trigger consult-lsp-file-symbols or consult-imenu."
    (interactive)
    (if (and (fboundp 'consult-lsp-file-symbols)
             (bound-and-true-p lsp-mode))
        (condition-case nil
            (consult-lsp-file-symbols)
          (error (consult-imenu)))
      (consult-imenu))))

;; 🔑 ALL consult--* customization must happen AFTER load
(with-eval-after-load 'consult
  (defvar siren-consult--source-recent-file-hidden
    (let ((source (copy-tree consult--source-recent-file)))
      (plist-put source :hidden t)
      source)
    "Hidden recent file source for `consult-buffer'.")

  (defvar siren-consult--source-project-buffer-hidden
    (let ((source (copy-tree consult--source-project-buffer)))
      (plist-put source :category 'project-buffer)
      (plist-put source :hidden t)
      source)
    "Hidden project buffer source for `consult-buffer'.")

  (defvar siren-consult--source-project-buffer
    (let ((source (copy-tree consult--source-project-buffer)))
      (plist-put source :category 'project-buffer)
      (cl-remf source :hidden)
      (cl-remf source :narrow)
      source)
    "Project buffer source for `consult-project-buffer'.")

  (defvar siren-consult--source-project-recent-file-hidden
    (let ((source (copy-tree consult--source-project-recent-file)))
      (plist-put source :category 'project-file)
      (plist-put source :hidden t)
      source)
    "Hidden project recent file source.")

  (defvar siren-consult--source-project-recent-file
    (let ((source (copy-tree consult--source-project-recent-file)))
      (plist-put source :category 'project-file)
      (cl-remf source :hidden)
      (cl-remf source :narrow)
      source)
    "Project recent file source.")

  (setq consult-buffer-sources
        '(consult--source-hidden-buffer
          consult--source-modified-buffer
          consult--source-buffer
          siren-consult--source-recent-file-hidden
          consult--source-bookmark
          siren-consult--source-project-buffer-hidden
          siren-consult--source-project-recent-file-hidden)

        consult-project-buffer-sources
        '(siren-consult--source-project-buffer
          siren-consult--source-project-recent-file)))

(use-package consult-dir
  :after consult
  :general
  (:keymaps '(minibuffer-local-completion-map vertico-map
                                              selectrum-minibuffer-map)
            "C-x C-d" 'consult-dir
            "C-x C-j" 'consult-dir-jump-file))

(provide 'siren-consult)
;;; siren-consult.el ends here
