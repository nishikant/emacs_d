(add-to-list 'auto-mode-alist '("\\.hamlc\\'" . haml-mode))

(defun customizations-for-haml-mode ()
  (interactive)
  (flyspell-prog-mode)
  (linum-mode t)
  (fci-mode)
  (auto-complete-mode)
  (setq tab-width 2)
  (setq highlight-indentation-offset 2)
  (highlight-indentation-mode)
  (highlight-indentation-current-column-mode))

(add-hook 'haml-mode-hook 'customizations-for-haml-mode)
