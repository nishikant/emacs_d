;;; siren-gnupg.el --- jimeh's Emacs Siren: gnupg configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for gnupg.

;;; Code:


(require 'epa-file)
(epa-file-enable)
(setq epa-file-encrypt-to "gattusevalkar@gmail.com")
(setq epg-pinentry-mode 'loopback)
(setq org-crypt-key "gattusevalkar@gmail.com")


(require 'org-crypt)
(org-crypt-use-before-save-magic)

(setq org-tags-exclude-from-inheritance (quote ("crypt")))
(defun yt/gpg--kill-gpg-buffers ()
  "It attempts to close all the file visiting buffers whose filename ends with .gpg.

It will ask for confirmation if the buffer is modified but unsaved."

  (kill-matching-buffers "\\.gpg$" nil t)
  )

(provide 'siren-gnupg)
;;; siren-gnupg.el ends here
