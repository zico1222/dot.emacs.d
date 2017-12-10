;; read ~/.emacs.d/site-lisp/*
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(package-initialize)

(require 'cl)

(defvar installing-package-list
  '(
    init-loader
    use-package
    auto-complete
    markdown-mode
    haskell-mode
    hlinum
    flycheck
    zenburn-theme
    helm
    smartparens
    rainbow-delimiters
    solarized-theme
    move-text
    anzu
    volatile-highlights
    powerline
    undohist
    point-undo
    tuareg
    undo-tree
    yaml-mode
    auctex
    dracula-theme
    mozc
    mozc-im
    ac-mozc
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(setq init-loader-byte-compile t)
(init-loader-load "~/.emacs.d/inits")
(push "~/.opam/4.04.1/share/emacs/site-lisp/" load-path) ; directory containing merlin.el
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f5512c02e0a6887e987a816918b7a684d558716262ac7ee2dd0437ab913eaec6" default)))
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (ac-mozc zenburn-theme yascroll yaml-mode volatile-highlights use-package undohist undo-tree tuareg solarized-theme smartparens rainbow-delimiters powerline point-undo mozc-im move-text markdown-mode init-loader hlinum helm haskell-mode flycheck el-get dracula-theme auto-complete auctex anzu)))
 '(scroll-step 0)
 '(scroll-up-aggressively nil)
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
