;;; Load Path
(normal-top-level-add-subdirs-to-load-path)
(add-to-list 'load-path "~/.emacs.d/")

;;; Keyboard setup
; This causes C-h to function like backspace.
(define-key global-map [(control h)] 'backward-delete-char)

(require 'smarttabs)
(setq-default indent-tabs-mode nil)

; Mac specific setup
(if (eq system-type 'darwin)
    (setq mac-command-modifier 'meta)
  (normal-erase-is-backspace-mode 1))

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; (when
;;     (load
;;      (expand-file-name "~/.emacs.d/elpa/package.el"))
;;   (package-initialize))
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;;;
;;; Helper Functions
;;;
(defun add-hook-to-modes (hook modes)
  "Used to add a hook to multiple modes.  Expects mode to be a list of modes
   to add to."
  (mapcar (lambda (mode) (add-hook mode hook))
	  modes))

;;; Set up CoffeeScript mode
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;;; Multimode
(require 'multi-mode)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(require 'web-mode) 
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode)) 
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; Contains a list of the lisp modes.  Useful when adding
;; hooks to modes in bulk.
(defconst lisp-modes
  '(emacs-lisp-mode-hook
    lisp-mode-hook
    lisp-interaction-mode-hook
    scheme-mode-hook
    clojure-mode-hook))

;;; Attach paredit as a minor mode to all the major lisp modes.
(add-hook-to-modes (lambda () (paredit-mode +1)) lisp-modes)

(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-midnight)))

;;; Rainbow delimiters
(require 'rainbow-delimiters)
(add-hook-to-modes 'rainbow-delimiters-mode lisp-modes)

(setq linum-format "%5d ")
(global-linum-mode 1)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "grey85" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "apple" :family "Bitstream Vera Sans Mono")))))

(setq inhibit-splash-screen t)

;; Move the backup files to a different location so they don't pollute source
;; trees.
(setq backup-directory-alist `(("." . "~/.saves")))

 (require 'auto-complete-config)
 (add-to-list 'ac-dictionary-directories
     "~/.emacs.d/.cask/24.3.50.1/elpa/auto-complete-20130724.1750/dict")
 (ac-config-default)
 (setq ac-ignore-case nil)
 (add-to-list 'ac-modes 'enh-ruby-mode)
 (add-to-list 'ac-modes 'web-mode)

 (require 'smartparens-config)
 (require 'smartparens-ruby)
 (smartparens-global-mode)
 (show-smartparens-global-mode t)
 (sp-with-modes '(rhtml-mode)
   (sp-local-pair "<" ">")
   (sp-local-pair "<%" "%>"))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html.erb\\'" . web-mode))

(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

(require 'robe)
(add-hook 'enh-ruby-mode-hook 'robe-mode)

(require 'powerline)
