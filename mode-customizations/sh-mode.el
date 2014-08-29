(add-to-list 'auto-mode-alist '("\\.bash\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.tcsh\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.tmuxtheme\\'" . sh-mode))

(defun customizations-for-sh-mode ()
  (interactive)
  (flyspell-prog-mode)
  (flycheck-mode)
  (linum-mode t)
  (fci-mode)
  (hs-minor-mode 1)
  (auto-complete-mode)
  (whitespace-mode)
  (subword-mode)
  (setq sh-basic-offset 2)
  (setq sh-indentation 2)
  (setq highlight-indentation-offset 2)
  (setq whitespace-action (quote (auto-cleanup)))
  (highlight-indentation-mode)
 (define-key sh-mode-map (kbd "RET") 'reindent-then-newline-and-indent))

(add-hook 'sh-mode-hook 'customizations-for-sh-mode)
