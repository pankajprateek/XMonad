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
 '(c-offsets-alist
   (quote
    ((namespace-open . 0)
     (namespace-close . 0)
     (innamespace . 0))))
 '(column-number-mode t)
 '(custom-enabled-themes (quote (molokai)))
 '(custom-safe-themes
   (quote
    ("3ba3197afe5418489acb6da4d12fb0fd3fd114ecc70a06598fb143e92a53e8f4" "9b35c097a5025d5da1c97dba45fed027e4fb92faecbd2f89c2a79d2d80975181" "d1ede12c09296a84d007ef121cd72061c2c6722fcb02cb50a77d9eae4138a3ff" "11e57648ab04915568e558b77541d0e94e69d09c9c54c06075938b6abc0189d8" "bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "c3d4af771cbe0501d5a865656802788a9a0ff9cf10a7df704ec8b8ef69017c68" "d3a406c5905923546d8a3ad0164a266deaf451856eca5f21b36594ffcb08413a" "bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "4e262566c3d57706c70e403d440146a5440de056dfaeb3062f004da1711d83fc" "53e29ea3d0251198924328fd943d6ead860e9f47af8d22f0b764d11168455a8e" "1989847d22966b1403bab8c674354b4a2adf6e03e0ffebe097a6bd8a32be1e19" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(doc-view-continuous t)
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands notifications readonly ring stamp spelling track)))
 '(global-auto-revert-mode t)
 '(haskell-mode-hook (quote (haskell-indentation-mode)))
 '(ido-vertical-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (flycheck persistent-scratch nimbus-theme flatland-theme monokai-alt-theme molokai-theme yaml-mode markdown-mode ido-vertical-mode origami smex bind-key god-mode color-theme-solarized solarized-theme folding adaptive-wrap magit-lfs magit clang-format monokai-theme hc-zenburn-theme sublime-themes auto-complete)))
 '(pdf-view-midnight-colors (quote ("white smoke" . "black")))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(standard-indent 2))
;; '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil :family "Source Code Pro" :foundry "adobe" :slant normal :weight normal :height 113 :width normal))))
 '(font-lock-comment-face ((t (:foreground "color-101")))))

(load "auctex.el" nil t t)
; (load "preview-latex.el" nil t t)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)

(setq line-move-visual t)

(global-visual-line-mode t)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
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
  (load-theme 'monokai))

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



; (set-default-font "Source Code Pro") ;;; set default font
(setq default-frame-alist '((font . "Source Code Pro"))) ;;; set default font for emacs --daemon / emacsclient


;; (pdf-tools-install)


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
(windmove-default-keybindings 'meta)


(defun ignore-error-wrapper (fn)
  "Funtion return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
  (let ((fn fn))
    (lambda ()
      (interactive)
      (ignore-errors
        (funcall fn)))))

;; (global-set-key [s-left] (ignore-error-wrapper 'windmove-left))
;; (global-set-key [s-right] (ignore-error-wrapper 'windmove-right))
;; (global-set-key [s-up] (ignore-error-wrapper 'windmove-up))
;; (global-set-key [s-down] (ignore-error-wrapper 'windmove-down))

;; (global-set-key (kbd "C-c <left>")  'windmove-left)
;; (global-set-key (kbd "C-c <right>") 'windmove-right)
;; (global-set-key (kbd "C-c <up>")    'windmove-up)
;; (global-set-key (kbd "C-c <down>")  'windmove-down)


(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
; (setq ido-use-filename-at-point 'guess)

(setq c-default-style "C++")
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.inl\\'" . c++-mode))

(defun my-c++-mode-hook ()
  (setq c-basic-offset 2)
  (c-set-offset 'inline-open 0)
  (c-set-offset 'case-label 2)
      (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)


(setq-default indent-tabs-mode nil)
(setq-default indent-label 2)
(setq-default tab-width 2)

; because need to emacs in mac over iterm
(global-set-key (kbd "C-h") 'delete-backward-char)

; Go to the matching paren if on a paren; otherwise insert %.
(global-set-key "%" 'match-paren)

(defun match-paren (arg)
  (interactive "p")
  (cond ((looking-at "\\s(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))




(require 'compile)
;; (add-hook 'c-mode-hook
;; 	  (lambda ()
;; 	    (unless (file-exists-p "Makefile")
;; 	      (set (make-local-variable 'compile-command)
;; 		   ;; emulate make's .c.o implicit pattern rule, but with
;; 		   ;; different defaults for the CC, CPPFLAGS, and CFLAGS
;; 		   ;; variables:
;; 		   ;; $(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $<
;; 		   (let ((file (file-name-nondirectory buffer-file-name)))
;; 		     (format "%s -o %s %s %s %s"
;; 			     (or (getenv "CC") "gcc")
;; 			     (file-name-sans-extension file)
;; 			     (or (getenv "CPPFLAGS") "-DDEBUG=9")
;; 			     (or (getenv "CFLAGS") "-ansi -pedantic -Wall -g")
;; 			     file))))))

;; (add-hook 'c++-mode-hook
;; 	  (lambda ()
;; 	    (unless (file-exists-p "Makefile")
;; 	      (set (make-local-variable 'compile-command)
;; 		   ;; emulate make's .c.o implicit pattern rule, but with
;; 		   ;; different defaults for the CC, CPPFLAGS, and CFLAGS
;; 		   ;; variables:
;; 		   ;; $(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $<
;; 		   (let ((file (file-name-nondirectory buffer-file-name)))
;; 		     (format "%s -o %s %s %s %s"
;; 			     (or (getenv "CC") "g++")
;; 			     (file-name-sans-extension file)
;; 			     (or (getenv "CPPFLAGS") "-DDEBUG=9")
;; 			     (or (getenv "CFLAGS") "-ansi -pedantic -Wall -g -lpthread -std=c++11 -Wunused")
;; 			     file))))))

; compile
(defun desperately-compile ()
  "Traveling up the path, find a Makefile and `compile'."
  (interactive)
  (when (locate-dominating-file default-directory "Makefile")
  (with-temp-buffer
    (setq currentdir (locate-dominating-file default-directory "Makefile"))
    (setq directory (file-name-nondirectory
                     (directory-file-name currentdir)))
    (setq path (file-name-directory
                (directory-file-name currentdir)))
    (add-to-list 'compilation-search-path path)
    (setq compile-command (concat (concat "cd " path) (concat " && make release --directory=" directory)))
    (call-interactively 'compile))))

(setq compilation-scroll-output 'first-error)

;; (defun compile-interactive ()
;;   (interactive)
;;   (setq current-prefix-arg '(4))
;;   (call-interactively 'desperately-compile))

(defun my-c-mode-common-hook ()
    (define-key c-mode-map (kbd "C-<f12>") 'compile))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun cc-mode-compile ()
  (local-set-key (kbd "C-x C m") 'desperately-compile))

(add-hook 'c-mode-hook 'cc-mode-compile)
(add-hook 'c++-mode-hook 'cc-mode-compile)

(global-set-key (kbd "<f12>") 'desperately-compile)


; clang-format on save
;; (defun format-buffer ()
;;   (interactive)
;;   (when c-buffer-is-cc-mode
;;     (clang-format-buffer)))
;; (add-hook 'before-save-hook 'format-buffer)

; yes-no to y-n
(defalias 'yes-or-no-p 'y-or-n-p)

; kill buffer unconditionally
;; (defun volatile-kill-buffer ()
;;    "Kill current buffer unconditionally."
;;    (interactive)
;;    (let ((buffer-modified-p nil))
;;      (kill-buffer (current-buffer))))

;; (global-set-key (kbd "C-x k") 'volatile-kill-buffer) 

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)


;; ;; God Mode (No more emacs pinky)
;; (require 'god-mode)
;; (global-set-key (kbd "<escape>") 'god-mode-all)
;; (define-key god-local-mode-map (kbd "z") 'repeat)
;; (define-key god-local-mode-map (kbd "i") 'god-local-mode)

;; ;; Emacs use-package to do a global bind key
;; (require 'bind-key)
;; (bind-key* ";" 'god-mode-all)

;; ;; Key chord for switching god-mode
;; (require 'key-chord)
;; (key-chord-mode 1)
;; (setq key-chord-one-key-delay 0.4)
;; (defun write-semicolon () (interactive) (insert-char 59))
;; (key-chord-define-global ",," 'write-semicolon)




; maximize buffer
(defun toggle-maximize-buffer () "Maximize buffer"
       (interactive)
       (if (= 1 (length (window-list)))
           (jump-to-register '_)
         (progn
           (set-register '_ (list (current-window-configuration)))
           (delete-other-windows))))

(global-set-key (kbd "<f10>") 'toggle-maximize-buffer) 


; Moving cursor down at bottom scrolls only a single line, not half page
(setq scroll-step 1)
(setq scroll-conservatively 5)

(setq kill-whole-line t) 

(normal-erase-is-backspace-mode 1)

; emacs backup files
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

(custom-set-variables
 '(ediff-split-window-function (quote split-window-horizontally)))



;; until you learn
; (global-unset-key (kbd "<left>"))
; (global-unset-key (kbd "<right>"))
; (global-unset-key (kbd "<up>"))
; (global-unset-key (kbd "<down>"))

(defmacro ins-val (val)
  `(lambda () (interactive) (insert ,val)))

(define-minor-mode special-char-mode
  "Toggle Special Character mode"
  nil
  " SpecialChar"
  `(
    (,(kbd "1") . ,(ins-val "!")) (,(kbd "!") . ,(ins-val "1"))
    (,(kbd "2") . ,(ins-val "@")) (,(kbd "@") . ,(ins-val "2"))
    (,(kbd "3") . ,(ins-val "#")) (,(kbd "#") . ,(ins-val "3"))
    (,(kbd "4") . ,(ins-val "$")) (,(kbd "$") . ,(ins-val "4"))
    (,(kbd "5") . ,(ins-val "%")) (,(kbd "%") . ,(ins-val "5"))
    (,(kbd "6") . ,(ins-val "^")) (,(kbd "^") . ,(ins-val "6"))
    (,(kbd "7") . ,(ins-val "&")) (,(kbd "&") . ,(ins-val "7"))
    (,(kbd "8") . ,(ins-val "*")) (,(kbd "*") . ,(ins-val "8"))
    (,(kbd "9") . ,(ins-val "(")) (,(kbd "(") . ,(ins-val "9"))
    (,(kbd "0") . ,(ins-val ")")) (,(kbd ")") . ,(ins-val "0"))
    (,(kbd "_") . ,(ins-val "-")) (,(kbd "-") . ,(ins-val "_"))
    )
  :global 'true)

(global-set-key (kbd "C-!") 'special-char-mode)

(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))


; (setq org-latex-listings t)
; (add-to-list 'org-latex-packages-alist '("" "listings"))
; (add-to-list 'org-latex-packages-alist '("" "color"))
; (require 'org)
; (require 'ox-latex)
; (add-to-list 'org-latex-packages-alist '("" "minted"))
; (setq org-latex-listings 'minted) 

; (setq org-latex-pdf-process
;       '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

; (setq org-src-fontify-natively t)

; (setq org-latex-listings t)
; (add-to-list 'org-latex-packages-alist '("" "listings"))
; (add-to-list 'org-latex-packages-alist '("" "color"))

; (org-babel-do-load-languages
;  'org-babel-load-languages
;  '((R . t)
;    (C . t)
;    (latex . t)))