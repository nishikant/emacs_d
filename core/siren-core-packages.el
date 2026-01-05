;;; siren-core-packages.el --- jimeh's Emacs Siren: Core package setup  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Install and configure various packages that the core of Siren depends on.

;;; Code:

;; TODO: Look into a better solution for this workaround.
;;
;; Hacky workaround for recursive load error caused by jka-compr when
;; load-prefer-newer is enabled.
(setq load-prefer-newer nil)
(require 'jka-compr)
(setq load-prefer-newer t)

;; Basic Elpaca configuration.
(setq use-package-always-ensure t)
(setq elpaca-queue-limit 30)

;;
;; Install Elpaca package manager.
;;

(defvar elpaca-installer-version 0.11)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/jimeh/elpaca.git"
                              :branch "lock-file-improvements"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Enable Elpaca support for use-package's :ensure keyword.
(elpaca elpaca-use-package
  (elpaca-use-package-mode))

;; Ensure async native compilation is triggered when Elpaca builds a package.
(defun siren-elpaca--async-native-compile (e)
  "Trigger async native compilation for E's package."
  (when (and (featurep 'native-compile)
             (native-comp-available-p))
    (native-compile-async (elpaca<-build-dir e) 'recursively))
  (elpaca--continue-build e))

(siren-add-after elpaca-build-steps
                 'siren-elpaca--async-native-compile 'elpaca--byte-compile)

(provide 'siren-core-packages)
;;; siren-core-packages.el ends here
