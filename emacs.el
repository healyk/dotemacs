;;; Load Path
(add-to-list 'load-path "~/.emacs.d/")

;;; Keyboard setup
; This causes C-h to function like backspace.
(define-key global-map "\C-h" 'backward-delete-char)

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
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

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

;;; Rainbow delimiters
(require 'rainbow-delimiters)
(add-hook-to-modes 'rainbow-delimiters-mode lisp-modes)

;;; Show the 80 column indicator
(require 'fill-column-indicator)
(define-globalized-minor-mode 
  global-fci-mode fci-mode (lambda () (fci-mode t)))
(global-fci-mode t)
(setq fci-rule-color "darkred")
(setq-default fill-column 80)

(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-midnight)))

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