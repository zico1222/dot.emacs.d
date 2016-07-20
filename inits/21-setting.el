;; face
(custom-set-variables
 '(show-paren-mode t)
 '(global-linum-mode t)
 '(scroll-up-aggressively nil)
 '(scroll-step 0)
 '(inhibit-startup-screen t))
(load-theme 'zenburn t)
(set-frame-parameter nil 'alpha 90)
(setq x-select-enable-clipboard t)
(setq-default tramp-persistency-file-name nil)
(setq linum-format "%4d ")
(set-face-attribute 'linum nil
                    :foreground "lightgreen")
(custom-set-faces
 '(default ((t (:family "RictyDiminished" :boundry "unknown" :height 130)))))
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; mouse
(xterm-mouse-mode t)
(require 'mouse)
(require 'mwheel)
(mouse-wheel-mode t)

;; backup file
(setq backup-directory-alist
      (cons (cons ".*" (expand-file-name "~/.emacs.d/backup/"))
            backup-directory-alist))
(setq auto-save-file-name-transforms
      `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

;; rectangle selection
(cua-mode t)
(setq cua-enable-cua-keys nil)
(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)
(defun my/rectangle-region ()
  (interactive)
  (if (region-active-p)
      (cua-set-rectangle-mark)
    (cua-set-mark)))
(define-key global-map (kbd "C-@") 'my/rectangle-region)

;; packages
(require 'use-package)

(use-package auto-complete-config
  :config
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict/")
  (ac-config-default))

(use-package yatex
  :config
  (setq YaTeX-kanji-code 4)
  (add-hook 'yatex-mode-hook '(lambda () (auto-fill-mode -1)))
  :mode (("\\.tex\\'" . yatex-mode)))

(use-package hlinum
  :config
  (hlinum-activate))

(use-package whitespace
  :config
  (setq-default tab-width 2 indent-tabs-mode nil)
  (set-face-foreground 'whitespace-space "DarkGoldenrod1")
  (set-face-background 'whitespace-space nil)
  (set-face-bold-p 'whitespace-space t)
  (set-face-foreground 'whitespace-tab "DarkOliveGreen1")
  (set-face-background 'whitespace-tab nil)
  (set-face-underline  'whitespace-tab t)
  (setq whitespace-style '(face tabs tab-mark spaces space-mark))
  (setq whitespace-space-regexp "\\(\x3000+\\)")
  (setq whitespace-display-mappings
        '((space-mark ?\u3000 [?\u25a1])))
  (global-whitespace-mode 1))

(use-package markdown-mode
  :mode (("\\.txt\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)))

(use-package tramp
  :config
  (setq tramp-default-method "ssh")
  (setq tramp-shell-prompt-pattern "^.*[#$%>] *"))

(use-package flycheck
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package helm-mode
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("M-y" . helm-show-kill-ring)
         ("C-x C-r" . helm-recentf)
         ("C-x b" . helm-buffers-list)))

(use-package smartparens-config
  :config
  (smartparens-global-mode t))

(use-package rainbow-delimiters
  :init
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'lisp-mode-hook 'rainbow-delimiters-mode))

(use-package move-text
  :bind (("M-<up>" . move-text-up)
         ("M-<down>" . move-text-down)))

(use-package anzu
  :config
  (global-anzu-mode +1))

(use-package volatile-highlights
  :config
  (volatile-highlights-mode t))

(use-package yascroll
  :config
  (global-yascroll-bar-mode 1))

(use-package undohist
  :config
  (undohist-initialize))

(use-package point-undo
  :bind (("M-u" . point-undo)
         ("M-r" . point-redo)))

(use-package undo-tree
  :config
    (global-undo-tree-mode t))
