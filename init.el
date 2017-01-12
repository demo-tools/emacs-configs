;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(company-idle-delay 0.08)
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(package-selected-packages
   (quote
    (org-pdfview popwin counsel swiper smex yasnippet ace-jump-mode solarized-theme color-theme-solarized on-screen))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-linum-mode t)
(global-company-mode t)

;这部分有问题
;(org-babel-do-load-languages
;      'org-babel-load-languages
;      '((shell . t)
;	(C . t)
;	(C++ . t)
;	(python . t)
;	(org . t)))

 
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq-default inhibit-splash-screen t)


(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f1>") 'open-my-init-file)

(setq auto-save-default nil)




;文本块代码高亮
(require 'org)
(setq org-src-fontify-natively t)


;最近打开文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


;delete selection mode

(delete-selection-mode t)

; 全屏
(setq initial-frame-alist (quote ((fullscreen . maximized))))

; add hook


; 高亮当前行
(global-hl-line-mode t)

; add melpa to the package-archives path
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
(package-initialize))

(require 'cl)

;;do this sometimes later
(defvar yingdai/packages '(
			   company
			   hungry-delete
			   yasnippet
			   swiper
			   counsel
			   smartparens
			   popwin
			   ) "Default packages")

;; M-x package auto
;;(defvar package-selected-packages '(append package-selected-packages  yingdai/packages))

;; (print package-selected-packages)

(defun yingdai/packages-installed-p ()
  (loop for pkg in yingdai/packages
	when (not (package-installed-p pkg))
	do (return nil)
	finally (return t)))

(unless (yingdai/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg yingdai/packages)
    (message "%s" pkg)
    (when (not (package-installed-p pkg))
      (package-install pkg))))


;;======
(require 'hungry-delete)
(global-hungry-delete-mode)




;==========================================================
; set the emacs theme
(require 'color-theme)
(color-theme-initialize)  
;; 这个是你选择的主题，后面的calm forest就是它的名字，注意使用小写。
(color-theme-solarized-dark)

					; if you want to install a theme
					;first M-x package-install solarized-theme
					;and M-x load-theme solarized-dark not solarized
					;can open the file of emacs.d/elpa/solarized-theme-20161222.109 and will see some files of elisp



;; org
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-agenda-files '("~/org/"))

; ace jump settings
(add-to-list 'load-path "~/.emacs.d/elpa")
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(setq make-backup-files nil)

; 括号匹配
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

(require 'yasnippet)
(yas-global-mode 1)


;;
(require 'smex) ;; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
					;; when Smex is auto-initialized on its first run.

;;(global-set-key (kbd "M-x") 'smex)
;;(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
;;(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)


;;smartparens
(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)

(smartparens-global-mode t)
;单引号
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)

(global-auto-revert-mode t)
(setq auto-save-default nil)

;; 用简单的缩写代替复杂的字符  例如 输入 yd 然后按 SPACE 键
;; Reference: https://www.emacswiki.org/emacs/AbbrevMode
(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table
  '(
        ("yd" "yingdai")
	("zsmly" "☺")
	("yemail" "yingdai123@gmail.com")
	))


(fset 'yes-or-no-p 'y-or-n-p)

;;http://book.emacs-china.org/#orgheadline13

(put 'dired-find-alternate-file 'disabled nil)

;; 主动加载 Dired Mode
;; (require 'dired)
;; (defined-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

;; 延迟加载
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))


(setenv "PATH" (concat (getenv "PATH") ":/usr/local/texlive/2016/bin/x86_64-darwin/"))

(setq exec-path (append exec-path '("/usr/local/texlive/2016/bin/x86_64-darwin/")))

(setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f" 
                                                    "xelatex -interaction nonstopmode %f"))
