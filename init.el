;; default

(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

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

;; show display time
(display-time)

;; show line num
(require 'linum)
(global-linum-mode 1)

;; hide menu bar
(menu-bar-mode 0)

;; highlight paren
(show-paren-mode 1)

;; no show menu if launch
(if (eq window-system 'x)
    (menu-bar-mode 1) (menu-bar-mode 0))
(menu-bar-mode nil)

;; keymap

(when (eq system-type 'darwin)
  ;; map `command` to `super`
  (setq mac-command-modifier 'super))

;; enable clipboard
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
