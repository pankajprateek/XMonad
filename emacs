;(setenv "PATH" (concat (getenv "PATH") ":/home/pankaj/.cabal/bin/"))
;(setq exec-path (append exec-path '("/home/pankaj/.cabal/bin/")))
;(setq exec-path-from-shell-initialize)
;(setq exec-path-from-shell-copy-env "PATH")


(defun set-exec-path-from-shell ()
  "Sets the exec-path to the same value used by the user shell"
  (let ((path-from-shell
	 (replace-regexp-in-string
	  "[[:space:]\n]*$" ""
	  (shell-command-to-string "$SHELL -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

;; call function now
(set-exec-path-from-shell)

;; auto-complete
;; (add-to-list 'load-path "~/.emacs.d/")
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
;; (ac-config-default)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("4e262566c3d57706c70e403d440146a5440de056dfaeb3062f004da1711d83fc" "53e29ea3d0251198924328fd943d6ead860e9f47af8d22f0b764d11168455a8e" "1989847d22966b1403bab8c674354b4a2adf6e03e0ffebe097a6bd8a32be1e19" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(doc-view-continuous t)
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands notifications readonly ring stamp spelling track)))
 '(haskell-mode-hook (quote (haskell-indentation-mode)))
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(pdf-view-midnight-colors (quote ("white smoke" . "black")))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil :family "Source Code Pro" :foundry "adobe" :slant normal :weight normal :height 113 :width normal))))
 '(font-lock-comment-face ((t (:foreground "Red")))))

;(load "auctex.el" nil t t)
;(load "preview-latex.el" nil t t)

;(setq TeX-auto-save t)
;(setq TeX-parse-self t)
;(setq TeX-save-query nil)
;(setq TeX-PDF-mode t)

(setq line-move-visual t)

(global-visual-line-mode t)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
      package-archives )
(package-initialize)

(require 'auto-complete)
(global-auto-complete-mode t)
(setq ac-modes '(c++-mode sql-mode haskell-mode python-mode))

(defun auto-complete-mode-maybe ()
  "No maybe for you. Only AC!"
  (unless (minibufferp (current-buffer))
    (auto-complete-mode 1)))

;; (load-file (let ((coding-system-for-read 'utf-8))
;;                 (shell-command-to-string "agda-mode locate")))

;; Highlight current line
;; (global-hl-line-mode 1)

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

(defun use-default-theme ()
  (interactive)
  (load-theme 'junio))

(add-hook 'after-init-hook 'use-default-theme)

(add-hook 'lisp-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))

(setq view-diary-entries-initially t
       mark-diary-entries-in-calendar t
       number-of-diary-entries 7)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

(add-hook 'pdf-view-mode-hook 'auto-revert-mode)


;; Helper for compilation. Close the compilation window if
;; there was no error at all.
(defun compilation-exit-autoclose (status code msg)
  ;; If M-x compile exists with a 0
  (when (and (eq status 'exit) (zerop code))
    ;; then bury the *compilation* buffer, so that C-x b doesn't go there
    (bury-buffer)
    ;; and delete the *compilation* window
    (delete-window (get-buffer-window (get-buffer "*tex-shell*"))))
  ;; Always return the anticipated result of compilation-exit-message-function
  (cons msg code))
;; Specify my function (maybe I should have done a lambda function)
(setq compilation-exit-message-function 'compilation-exit-autoclose)

(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;; mapping f-12 to C-u M-x compile (interactive compile)
(defun compile-interactive ()
  (interactive)
  (setq current-prefix-arg '(4))
  (call-interactively 'compile))

(global-set-key (kbd "<f12>") 'compile-interactive)

;; (defun my-c-mode-common-hook ()
;;     (define-key c-mode-map (kbd "C-<f12>") 'compile))
;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(require 'compile)
(add-hook 'c-mode-hook
	  (lambda ()
	    (unless (file-exists-p "Makefile")
	      (set (make-local-variable 'compile-command)
		   ;; emulate make's .c.o implicit pattern rule, but with
		   ;; different defaults for the CC, CPPFLAGS, and CFLAGS
		   ;; variables:
		   ;; $(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $<
		   (let ((file (file-name-nondirectory buffer-file-name)))
		     (format "%s -o %s %s %s %s"
			     (or (getenv "CC") "gcc")
			     (file-name-sans-extension file)
			     (or (getenv "CPPFLAGS") "-DDEBUG=9")
			     (or (getenv "CFLAGS") "-ansi -pedantic -Wall -g")
			     file))))))

(add-hook 'c++-mode-hook
	  (lambda ()
	    (unless (file-exists-p "Makefile")
	      (set (make-local-variable 'compile-command)
		   ;; emulate make's .c.o implicit pattern rule, but with
		   ;; different defaults for the CC, CPPFLAGS, and CFLAGS
		   ;; variables:
		   ;; $(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $<
		   (let ((file (file-name-nondirectory buffer-file-name)))
		     (format "%s -o %s %s %s %s"
			     (or (getenv "CC") "g++")
			     (file-name-sans-extension file)
			     (or (getenv "CPPFLAGS") "-DDEBUG=9")
			     (or (getenv "CFLAGS") "-ansi -pedantic -Wall -g -lpthread -std=c++11 -Wunused")
			     file))))))


(set-default-font "Source Code Pro") ;;; set default font
(setq default-frame-alist '((font . "Source Code Pro"))) ;;; set default font for emacs --daemon / emacsclient


(pdf-tools-install)


;; (defun my-compilation-hook ()
;;   (when (not (get-buffer-window "*compilation*"))
;;     (save-selected-window
;; ;;;      (let* (x (current-buffer))
;; 	(save-excursion
;; 	  (let* ((w (split-window-horizontally))
;;                ;;; (h (window-height w))
;; 		 )
;; 	    (select-window w)
;; 	    (switch-to-buffer "*compilation*")
;;           ;;; (shrink-window (- h compilation-window-height))
;; 	    (switch-to-buffer x)
;; ;;;	    )
;; 	  )))))
;; (add-hook 'compilation-mode-hook 'my-compilation-hook)


(setq split-height-threshold 0)
(setq split-width-threshold nil)


(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(defun ignore-error-wrapper (fn)
  "Funtion return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
  (let ((fn fn))
    (lambda ()
      (interactive)
      (ignore-errors
        (funcall fn)))))

(global-set-key [s-left] (ignore-error-wrapper 'windmove-left))
(global-set-key [s-right] (ignore-error-wrapper 'windmove-right))
(global-set-key [s-up] (ignore-error-wrapper 'windmove-up))
(global-set-key [s-down] (ignore-error-wrapper 'windmove-down))

(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

