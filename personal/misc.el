;;Add monokai theme
(prelude-require-package 'monokai-theme)
(load-theme 'monokai t)

;;set the font, this seems to work for the emacs deamon
(add-to-list 'default-frame-alist '(font .   "Source Code Pro 12" ))
(global-visual-line-mode t)

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

;;store backups in one folder instead of next to the file
(setq backup-directory-alist `(("." . "~/.emacs.d/.backups")))

;;save curosr position when reopening a file
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

(prelude-require-package 'yasnippet)

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"
        ))

(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook 'yas-minor-mode)

(defun mark-this-window-as-main ()
  "Mark the current window as the main window."
  (interactive)
  (mapc (lambda (win) (set-window-parameter win 'main nil))
    (window-list))
  (set-window-parameter nil 'main t))

(defun get-main-window()
  "Find and return the main window or nil if non exists."
  (cl-find-if (lambda (win) (window-parameter win 'main)) (window-list)))

(defun just-my-main-window ()
  "Show only the main window"
  (interactive)
  (delete-other-windows (get-main-window)))

(add-hook 'prog-mode-hook 'mark-this-window-as-main)
(add-hook 'text-mode-hook 'mark-this-window-as-main)
(global-set-key (kbd "C-c C-m") 'just-my-main-window)
