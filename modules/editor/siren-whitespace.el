;;; siren-whitespace.el --- jimeh's Emacs Siren: whitespace configuration.

;;; Commentary:

;; Basic configuration for whitespace package

;;; Code:

(use-package whitespace
  :straight (:type built-in)
  :diminish whitespace-mode global-whitespace-mode
  :hook
  (prog-mode . whitespace-cleanup-on-save-mode)

  :preface
  (define-minor-mode whitespace-cleanup-on-save-mode
    "Run whitespace-cleanup on buffer save"
    :global nil
    (if whitespace-cleanup-on-save-mode
        (add-hook 'before-save-hook 'whitespace-cleanup-on-save-cleanup)
      (remove-hook 'before-save-hook 'whitespace-cleanup-on-save-cleanup)))

  (defun whitespace-cleanup-on-save-cleanup()
    (when (bound-and-true-p whitespace-cleanup-on-save-mode)
      (whitespace-cleanup)))

  :custom
  (whitespace-line-column 80)
  (whitespace-style '(face tabs trailing space-before-tab newline
                           indentation space-after-tab tab-mark newline-mark
                           empty))
  (whitespace-display-mappings '((newline-mark ?\n
                                               [?\u00AC ?\n] ;; \u00AC = ¬
                                               [?$ ?\n])
                                 (tab-mark ?\t
                                           [?\u2192 ?\t] ;; \u2192 = →
                                           [?\u00BB ?\t] ;; \u00BB = »
                                           [?\\ ?\t]))))

(provide 'siren-whitespace)
;;; siren-whitespace.el ends here
