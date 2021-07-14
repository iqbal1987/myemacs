(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)

(require 'org) 
(require 'ox)
;;(require 'cl)  
(setq org-export-async-debug nil)
(setq org-latex-pdf-process
  '("latex -shell-escape -interaction nonstopmode -output-directory %o %f"
  "bibtex $(basename %b)"
  "latex -shell-escape -interaction nonstopmode -output-directory %o %f"
  "dvips -o %b.ps %b.dvi"
  "ps2pdf %b.ps"))