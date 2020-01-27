;;  Package-Requires: ((dash "2.16.0"))
;; --------------------------- package manager --------------------------------------

;; init package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; ------------------------- locale and encoding ------------------------------------

;; locale environment
(set-locale-environment nil)
;; language
(set-language-environment "Japanese")
;; terminal encoding
(set-terminal-coding-system 'utf-8)
;; keyboard encoding
(set-keyboard-coding-system 'utf-8)
;; buffer file encoding
(set-buffer-file-coding-system 'utf-8)

;; ----------------------------- package config -------------------------------------

;; load material theme
(load-theme 'material t)

;; load autocomplete
(ac-config-default)

;; load rainbow delimiters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; syntax highlight of dash
(eval-after-load 'dash '(dash-enable-font-lock))

;; neotree
(use-package neotree
  :after
  projectile
  :commands
  (neo-tree-show neotree-hide neotree-dir neotree-find)
  :custom
  (neo-theme 'nerd2)
  :bind
  ("<f8>" . 'neotree-projectile-toggle)
  :preface
  (defun neotree-projectile-toggle ()
    (interactive)
    (let ((porject-dir
	   (ignore-errors
	     (projectile-project-root)
	     ))
	  (file-name (buffer-file-name))
	  (neo-smart-open t))
      (if (and (fboundp 'neo-global--window-exists-p)
	       (neo-global--window-exists-p))
	  (neotree-hide)
	(progn
	  (neotree-show)
	  (if project-dir
	      (neotree-dir project-dir))
	  (if file-name
	      (neotree-find file-name)))))))

;; which-key
(use-package which-key
  :diminish
  which-key-mode
  :hook
  (after-init . which-key-mode))

;; select packages
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d1c7f2db070c96aa674f1d61403b4da1fff2154163e9be76ce51824ed5ca709c" default)))
n '(package-selected-packages
   (quote
    (neotree which-key org-bullets org markdown-mode auto-complete dash material-theme popup rainbow-delimiters))))

;; ------------------------------- os config (mac) ----------------------------------

;; enable clipboard on osx
(defun copy-from-osx()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;; -------------------------------- display config ----------------------------------

;; show display time
(display-time)

;; show line num
(if (version<= "26.0.50" emacs-version)
    (progn
      (global-display-line-numbers-mode)))

;; highlight line
(global-hl-line-mode t)

;; hide menu bar
(menu-bar-mode -1)

;; highlight paren
(show-paren-mode 1)

;; no show toolbar
(when (display-graphic-p)
  (tool-bar-mode -1))

;; -------------------------------- keymap config ------------------------------------

;; keymap
(when (eq system-type 'darwin)
  ;; map `command` to `super`
  (setq mac-command-modifier 'super))

;; -------------------------------- other config -------------------------------------

;; enable macos clipboard
(setq x-select-enable-clipboard t)

;; remove a line contains new line
(setq kill-whole-line t)

;; no show startup message
(setq inhibit-startup-message t)

;; no make backup
(setq make-backup-files nil)

;; no make autosave backup
(setq auto-save-default nil)

;; remove initial message on *scratch*
(setq initial-scratch-message "")

;; paging per a line on scroll
(setq mouse-wheel-scroll-amount '(1 ((shift) . 5)))

;; ignore search case
(setq case-fold-search t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
