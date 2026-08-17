;;; siren-latex.el --- jimeh's Emacs Siren: latex configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for latex.

;;; Code:

(setq org-latex-compiler "xelatex")

(with-eval-after-load 'ox-latex
  ;; keep defaults, just add resume
  (add-to-list 'org-latex-classes
               '("resume"
                 "\\input{resume-template.tex}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

(provide 'siren-latex)
;;; siren-latex.el ends here
