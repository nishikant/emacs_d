;;
;; feature
;;

(require 'siren-programming)

(siren-require-packages '(feature-mode))

(defun siren-feature-mode-defaults ()
  (siren-prog-mode-defaults)
  (setq tab-width 2)
  (setq highlight-indentation-offset 2)
  (highlight-indentation-mode)
  (highlight-indentation-current-column-mode))

(setq siren-feature-mode-hook 'siren-feature-mode-defaults)

(add-hook 'feature-mode-hook (lambda ()
                               (run-hooks 'siren-feature-mode-hook)))


(provide 'siren-cucumber)