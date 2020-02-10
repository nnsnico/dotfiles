;;  Package-Requires: ((dash "2.16.0"))
;; --------------------------- package manager --------------------------------------

;; init package manager
(require 'package)

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package)  
  (setq use-package-always-ensure t))

;; neotree which-key org-bullets org markdown-mode auto-complete dash material-theme popup rainbow-delimiter

;; ------------------------- locale and encoding ------------------------------------

;; locale environment
(prefer-coding-system 'utf-8)
(set-locale-environment nil)
;; language
(set-language-environment "Japanese")
;; terminal encoding
(set-terminal-coding-system 'utf-8)
;; keyboard encoding
(set-keyboard-coding-system 'utf-8)
;; buffer file encoding
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)

;; ----------------------------- packages config -------------------------------------

;; popup
(use-package popup)

;; load material theme
(use-package material-theme
  :init
  (load-theme 'material t))

;; load autocomplete
(use-package auto-complete
  :init
  (ac-config-default))

;; load rainbow delimiters
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

;; syntax highlight of dash
(use-package dash
  :after
  (eval-after-load 'dash '(dash-enable-font-lock)))

;; neotree
(use-package all-the-icons)
(use-package neotree
  :init
  (setq-default neo-keymap-style 'concise)
  :config
  (setq neo-autorefresh nil)
  (setq neo-create-file-auto-open t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-show-hidden-files t)
  (bind-key "C-t" 'neotree-toggle)
  (bind-key "RET" 'neotree-enter-hide neotree-mode-map)
  (bind-key "a" 'neotree-hidden-file-toggle neotree-mode-map)
  (bind-key "<left>" 'neotree-select-up-node neotree-mode-map)
  (bind-key "<right>" 'neotree-change-root neotree-mode-map))

(defun neo-open-file-hide (full-path &optional arg)
  (neo-global--select-mru-window arg)
  (find-file full-path)
  (neotree-hide))

(defun neotree-enter-hide (&optional arg)
  (interactive "P")
  (neo-buffer--execute arg 'neo-open-file-hide 'neo-open-dir))

;; which-key
(use-package which-key
  :diminish
  which-key-mode
  :hook
  (after-init . which-key-mode))

;; git-gutter
(use-package git-gutter
  :config
  (global-git-gutter-mode t))
  
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
(setq inhibits-startup-message t)

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (all-the-icons which-key neotree dash rainbow-delimiters auto-complete material-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
