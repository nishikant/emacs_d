;;; siren-swiper.el --- jimeh's Emacs Siren: swiper configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for swiper.

;;; Code:

(require 'siren-ivy)

(use-package swiper
  :general
  ("C-s" 'swiper)

  :custom-face
  (ivy-current-match ((t (:background "#7e9fc9" :foreground "black"))))
  (swiper-line-face ((t (:background "#313c4d"))))

  :custom
  (ivy-use-virtual-buffers t)

  :config
  (ivy-mode 1))

(provide 'siren-swiper)
;;; siren-swiper.el ends here
