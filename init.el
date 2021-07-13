;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-startup-message t)

(print "Beginning of init")

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;;;;(setq inhibit-splash-screen t)
;;(unbind-key "C-x C-f") ;; find-file-read-only

(setq ring-bell-function 'ignore)

;; Enable transient mark mode. In emacs >23 it is already enabled
;;;;(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)

;; Make Org mode work with files ending in .org
;;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

;;(use-package org-bullets
;;  :ensure t
;;  :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
;;  :custom (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;;(require 'org-bullets)
;;(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; indentation for visual-line mode in Org major mode.
(setq org-startup-indented t)
(setq visual-line-mode t)

(setq inhibit-compacting-font-caches t)

(add-to-list 'load-path "~/path-to-yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'darktooth t)

(org-babel-do-load-languages
       'org-babel-load-languages
       '((python . t)
         (emacs-lisp . t)
         (dot . t)
         (jupyter . t)
	   ))

(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

;; Standard Jedi.el setting for python mode.
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)


;; LSP for Dart 
(setq package-selected-packages 
  '(dart-mode lsp-mode lsp-dart lsp-treemacs flycheck company which-key
    ;; Optional packages
    lsp-ui hover))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; optional if you want which-key integration
;;(use-package which-key
;;    :config
;;    (which-key-mode))

(setq lsp-keymap-prefix "C-c l")
(setq lsp-dart-sdk-dir "C:\\src\\flutter\\bin\\cache\\dart-sdk\\")

(add-hook 'dart-mode-hook 'lsp-deferred)
(add-hook 'dart-mode-hook 'which-key-mode)
(add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)

;; this prevents the analysis server asking to restart upon killing
(setq lsp-restart 'auto-restart)

;; thiss will shutdown the server when we kill the dart buffer
(setq lsp-keep-workspace-alive nil)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-minimum-prefix-length 1
      lsp-lens-enable t
      lsp-signature-auto-activate nil)
	  
;; NOTE: Run lsp-dart-dap-setup with M-x once (lifetime) to setup the debugging tool.
;; Later use dap-debug mode. lsp automatically enables debug.
 
 ;; another method: 
;;(use-package lsp-mode
;;  :init
;;  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;  (setq lsp-keymap-prefix "C-c l")
;;  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;;         (dart-mode . lsp)
;;         ;; if you want which-key integration
;;         (lsp-mode . lsp-enable-which-key-integration))
;;  :commands lsp)
 
(message "%s" "End of user made Init!") 



;;(add-to-list
;;      'TeX-command-list
;;      '("dvi2ps2pdf" "%(latex) %s && dvips %s.dvi && ps2pdf %s.ps %s.pdf" TeX-run-command nil t))


;;(setq org-latex-pdf-process ('(
;;"pdflatex -interaction nonstopmode -shell-escape -output-directory %o %f"
;;"bibtex $(basename %b)"
;;"pdflatex -interaction nonstopmode -shell-escape -output-directory %o %f"
;;"pdflatex -interaction nonstopmode -shell-escape -output-directory %o %f"
;;; We could end here, but repeat to ensure full completion.
;;"bibtex $(basename %b)"
;;"pdflatex -interaction nonstopmode -shell-escape -output-directory %o %f"
;;"pdflatex -interaction nonstopmode -shell-escape -output-directory %o %f")))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-export-async-init-file "~/.emacs.d/orgasyncexportinit.el")
 '(org-export-in-background nil)
 '(package-selected-packages
   '(jedi elpy zenburn-theme yasnippet-snippets use-package pdf-tools org-bullets jupyter dracula-theme darktooth-theme cyberpunk-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
