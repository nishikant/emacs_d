;;; siren-latex.el --- jimeh's Emacs Siren: latex configuration.  -*- lexical-binding: nil; -*-

;;; Commentary:

;; Basic configuration for latex.

;;; Code:

(setq org-latex-compiler "xelatex")

(setq org-latex-classes
      '(("resume"
         "\\input{resume-template.tex}"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

(provide 'siren-latex)
;;; siren-latex.el ends here
