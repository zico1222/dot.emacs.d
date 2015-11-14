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
    el-get
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
    smooth-scroll
    yascroll
    undohist
    point-undo
    tuareg
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))

;;(el-get-bundle gist:1776988:sense-region)

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")
