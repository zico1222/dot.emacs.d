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
(column-number-mode t)

;; mouse
;;(xterm-mouse-mode t)
;;(require 'mouse)
;;(require 'mwheel)
;;(mouse-wheel-mode t)

;; backup file
(setq backup-directory-alist
      (cons (cons ".*" (expand-file-name "~/.emacs.d/backup/"))
            backup-directory-alist))
(setq auto-save-file-name-transforms
      `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

;; delete trailing whitespace automatically
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; packages
(require 'use-package)

(use-package auto-complete-config
  :init
  ;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict/")
  (ac-config-default)
  (global-auto-complete-mode t)
  :config
  (setq auto-composition-mode nil)
  (setq ac-auto-start t)
  (ac-set-trigger-key "TAB")
  (setq ac-use-menu-map t)
  (setq ac-use-fuzzy t)
  )

;; rectangle editing
(defun my/set-mark-command ()
  (interactive)
  (if (bound-and-true-p rectangle-mark-mode)
      (rectangle-mark-mode -1)
    (if (region-active-p)
        (rectangle-mark-mode 1)
      (set-mark (point)))))
(bind-key "C-@" 'my/set-mark-command)

;; auctex
(use-package tex-site
  :config
  (require 'tex-jp)
  (defun replace-dot-comma ()
    "s/。/．/g; s/、/，/g;する"
    (interactive)
    (let ((curpos (point)))
      (goto-char (point-min))
      (while (search-forward "。" nil t) (replace-match "．"))
      (goto-char (point-min))
      (while (search-forward "、" nil t) (replace-match "，"))
      (goto-char curpos)
      ))
  (setq TeX-default-mode 'japanese-latex-mode)
  (setq TeX-engine-alist '((platex "pLaTeX" "platex -shell-escape %S" "platex -shell-escape %S" "")))
  (setq japanese-TeX-engine-default 'platex)
  (setq-default TeX-engine 'platex)
  (setq japanese-TeX-command-default "pTeX")
  (setq japanese-LaTeX-command-default "pLaTeX")
  (setq LaTeX-parse-self t)
  (setq LaTeX-auto-save  t)
  (add-hook 'LaTeX-mode-hook
            (function (lambda ()
                        (add-to-list 'TeX-command-list
                                     '("evince" "evince '%s.pdf' " TeX-run-command t nil))
                        (add-to-list 'TeX-command-list
                                     '("pdf" "dvipdfmx -V 4 '%s' " TeX-run-command t nil))
                        (add-hook 'before-save-hook 'replace-dot-comma nil 'make-it-local)))))

(use-package hlinum
  :config
  (hlinum-activate))

;;(use-package whitespace
;;  :config
;;  (setq-default tab-width 2 indent-tabs-mode nil)
;;  (set-face-foreground 'whitespace-space "DarkGoldenrod1")
;;  (set-face-background 'whitespace-space nil)
;;  (set-face-bold-p 'whitespace-space t)
;;  (set-face-foreground 'whitespace-tab "DarkOliveGreen1")
;;  (set-face-background 'whitespace-tab nil)
;;  (set-face-underline  'whitespace-tab t)
;;  (setq whitespace-style '(face tabs tab-mark spaces space-mark))
;;  (setq whitespace-space-regexp "\\(\x3000+\\)")
;;  (setq whitespace-display-mappings
;;        '((space-mark ?\u3000 [?\u25a1])))
;;  (global-whitespace-mode 1))

(use-package markdown-mode
  :mode (("\\.txt\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)))

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

(use-package undohist
  :config
  (undohist-initialize))

(use-package point-undo
  :bind (("M-u" . point-undo)
         ("M-r" . point-redo)))

(use-package undo-tree
  :config
  (global-undo-tree-mode t))
