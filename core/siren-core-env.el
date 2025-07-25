;;; siren-core-env.el --- jimeh's Emacs Siren: Environment variable setup.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Setup for various environment variables to ensure external programs are
;; available.

;;; Code:

(use-package exec-path-from-shell
  :custom
  (exec-path-from-shell-variables '("PATH"
                                    "MANPATH"
                                    "TMPDIR"
                                    "KUBECONFIG"
                                    "GOPRIVATE"
                                    "LSP_USE_PLISTS"
                                    "RUST_BACKTRACE"
                                    "MallocNanoZone"))
  (exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-debug nil)

  :config
  (when (memq window-system '(mac ns x pgtk))
    (exec-path-from-shell-initialize)))

;; Set temporary-file-directory to match TMPDIR environment variable
(let ((tmpdir (getenv "TMPDIR")))
  (when (and tmpdir (not (string-blank-p tmpdir)))
    (setq temporary-file-directory tmpdir)))

;; Add bin directory within emacs configuration dir to `exec-path'.
(add-to-list 'exec-path (expand-file-name "bin" siren-dir))

(add-to-list 'exec-path (expand-file-name "~/go/bin/"))
(provide 'siren-core-env)
;;; siren-core-env.el ends here
