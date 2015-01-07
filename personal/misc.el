;;Add monokai theme
(prelude-require-package 'monokai-theme)
(load-theme 'monokai t)

;;set the font, this seems to work for the emacs deamon
(add-to-list 'default-frame-alist '(font .   "Source Code Pro 11" ))

;;Add resclient pacakge
(prelude-require-package 'restclient)

;;smooth scrolling
(setq scroll-margin 5
scroll-conservatively 9999
scroll-step 1)

;;powerline
(prelude-require-package 'powerline-evil)
(powerline-evil-vim-color-theme)
(display-time-mode t)

;;color identifies (colors every variable different)
(prelude-require-package 'color-identifiers-mode)
;;(add-hook 'prog-mode-hook 'global-color-identifiers-mode)
;;(global-color-identifiers-mode)

(prelude-require-package 'rainbow-delimiters)
;; (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;store backups in one folder instead of next to the file
(setq backup-directory-alist `(("." . "~/.emacs.d/.backups")))

;;save curosr position when reopening a file
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

;;Enable bear mode  (hotkeys and such)
(bear-mode 1)
