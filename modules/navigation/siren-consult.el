;;; siren-consult.el --- Modernized Siren Consult configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Modern Consult configuration compatible with current Consult releases.
;; Removes deprecated consult--* sources and relies on official APIs.

;;; Code:

(eval-when-compile
  (require 'cl-lib))

(with-eval-after-load 'diff
  (defvar coding-system--for-buffer-diff nil))

(use-package consult
  :defer t
  :general
  ("C-t"     #'siren-consult-imenu)
  ("C-x b"   #'consult-buffer)
  ("C-c b"   #'consult-project-buffer)
  ("M-g M-g" #'consult-goto-line)

  :custom
  (consult-preview-max-count 10)

  ;; Hide unwanted buffers using the supported filter mechanism
  (consult-buffer-show-hidden nil)
  (consult-buffer-filter
   '("\` "
     "\`\*tramp/"
     "\`\*Async-native-compile-log\*"
     "\`\*elpaca\*"
     "\`\*Messages\*"
     "\`\*Compile-Log\*"
     "\`\*Flymake log\*"
     "\`\*Backtrace\*"
     "\`\*code\*"
     "\`\*copilot\*"
     "\`\*diff\*"
     "\`\*Echo\*"
     "\`\*Warnings\*"
     "\`\*lsp\*"
     "\`\*pdf\*"
     "\`\*eldoc\*"
     "\`\*LSP\*"
     "\`\*company\*"
     "\`\*jka\*"
     "\`\*Min\*"
     "\`\*work\*"))

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

(use-package consult-dir
  :after consult
  :general
  (:keymaps '(minibuffer-local-completion-map vertico-map)
            "C-x C-d" #'consult-dir
            "C-x C-j" #'consult-dir-jump-file))

(provide 'siren-consult)
;;; siren-consult.el ends here
