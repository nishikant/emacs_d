;;; siren-modules.el --- jimeh's Emacs Siren: Module loading.

;;; Commentary:

;; Load the modules!

;;; Code:

(setq siren-modules-dir (expand-file-name "modules" siren-dir))
(add-to-list 'load-path siren-modules-dir)

;; Modules
(require 'siren-aliases)
(require 'siren-anzu)
(require 'siren-avy)
(require 'siren-browse-kill-ring)
(require 'siren-company)
(require 'siren-diff-hl)
(require 'siren-dired)
(require 'siren-direx)
(require 'siren-dumb-jump)
(require 'siren-editorconfig)
(require 'siren-evil)
(require 'siren-flyspell)
(require 'siren-folding)
(require 'siren-full-ack)
(require 'siren-git-timemachine)
(require 'siren-github)
(require 'siren-global-keybindings)
(require 'siren-goto-chg)
(require 'siren-goto-symbol)
(require 'siren-haml)
(require 'siren-helm)
(require 'siren-ido)
(require 'siren-linum)
(require 'siren-linum-relative)
(require 'siren-magit)
(require 'siren-move-beginning-of-line)
(require 'siren-multiple-cursors)
(require 'siren-org-mode)
(require 'siren-package-lint)
(require 'siren-rainbow)
(require 'siren-scroll-half-screen)
(require 'siren-smartparens)
(require 'siren-smex)
(require 'siren-string-inflection)
(require 'siren-text-manipulation)
(require 'siren-toggle-quotes)
(require 'siren-undo-tree)
(require 'siren-window-management)
(require 'siren-yasnippet)
(require 'siren-zoom-window)
;; (require 'siren-auto-complete)
;; (require 'siren-edit-server)
;; (require 'siren-swiper)
;; (require 'siren-volatile-highlights)
;; (require 'siren-zone)

;; Project management
(require 'siren-neotree)
(require 'siren-projectile)
;; (require 'siren-ecb)
;; (require 'siren-project-explorer)
;; (require 'siren-treemacs)

;; Workspace management
(require 'siren-eyebrowse)
;; (require 'siren-elscreen)
;; (require 'siren-escreen)
;; (require 'siren-perspective)
;; (require 'siren-workgroups2)

;; Languages
(require 'siren-coffee)
(require 'siren-conf)
(require 'siren-css)
(require 'siren-cucumber)
(require 'siren-dockerfile)
(require 'siren-emacs-lisp)
(require 'siren-gitconfig)
(require 'siren-gitignore)
(require 'siren-go)
(require 'siren-js)
(require 'siren-json)
(require 'siren-jsx)
(require 'siren-lua)
(require 'siren-makefile)
(require 'siren-markdown)
(require 'siren-plantuml)
(require 'siren-php)
(require 'siren-ruby)
(require 'siren-sass)
(require 'siren-scss)
(require 'siren-sh)
(require 'siren-thrift)
(require 'siren-web-mode)
(require 'siren-yaml)

(provide 'siren-modules)
;;; siren-modules.el ends here
