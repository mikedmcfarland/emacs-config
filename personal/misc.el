;;get s for string manipulation
(prelude-require-package 's)


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

(prelude-require-package 'multiple-cursors)

;; =============================================================
;; Multiple cursors evil compat (use emacs mode during mc)
;; =============================================================
(defvar mc-evil-compat/evil-prev-state nil)
(defvar mc-evil-compat/mark-was-active nil)

(defun user-utils/evil-visual-or-normal-p ()
  "True if evil mode is enabled, and we are in normal or visual mode."
  (and (bound-and-true-p evil-mode)
       (not (memq evil-state '(insert emacs)))))

(defun mc-evil-compat/switch-to-emacs-state ()
  (when (user-utils/evil-visual-or-normal-p)

    (setq mc-evil-compat/evil-prev-state evil-state)

    (when (region-active-p)
      (setq mc-evil-compat/mark-was-active t))

    (let ((mark-before (mark))
          (point-before (point)))

      (evil-emacs-state 1)

      (when (or mc-evil-compat/mark-was-active (region-active-p))
        (goto-char point-before)
        (set-mark mark-before)))))

(defun mc-evil-compat/back-to-previous-state ()
  (when mc-evil-compat/evil-prev-state
    (unwind-protect
        (case mc-evil-compat/evil-prev-state
          ((normal visual) (evil-force-normal-state))
          (t (message "Don't know how to handle previous state: %S"
                      mc-evil-compat/evil-prev-state)))
      (setq mc-evil-compat/evil-prev-state nil)
      (setq mc-evil-compat/mark-was-active nil))))

(add-hook 'multiple-cursors-mode-enabled-hook
          'mc-evil-compat/switch-to-emacs-state)
(add-hook 'multiple-cursors-mode-disabled-hook
          'mc-evil-compat/back-to-previous-state)

(defun mc-evil-compat/rectangular-switch-state ()
  (if rectangular-region-mode
      (mc-evil-compat/switch-to-emacs-state)
    (setq mc-evil-compat/evil-prev-state nil)))

;; When running edit-lines, point will return (position + 1) as a
;; result of how evil deals with regions
(defadvice mc/edit-lines (before change-point-by-1 activate)
  (when (user-utils/evil-visual-or-normal-p)
    (if (> (point) (mark))
        (goto-char (1- (point)))
      (push-mark (1- (mark))))))

(add-hook 'rectangular-region-mode-hook 'mc-evil-compat/rectangular-switch-state)

(defvar mc--default-cmds-to-run-once nil)

;; (defun setWindowMargins(window)
;;   (set-window-margins 15 15)
;;   )

;; (defun setFrameMargins (frame)
;;   (cl-loop for window on '(window-list frame) do (setWindowMargins window)))

;; (add-hook 'window-size-change-functions 'setFrameMargins)
(defun set-my-margins()
  (setq left-margin-width 1)
  (setq right-margin-width 1))

(add-hook 'text-mode-hook 'set-my-margins)
(add-hook 'prog-mode-hook 'set-my-margins)
(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "->") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))

(defun bind-tab-properly ()
  "Binds tab to tab-indent-or-complete, overwritting yas and company bindings"
  (interactive)
  ;;overwrite yas and company tab mappings
  (define-key yas-minor-mode-map (kbd "<tab>") 'tab-indent-or-complete)
  (define-key yas-minor-mode-map (kbd "TAB") 'tab-indent-or-complete)
  (define-key company-active-map [tab] 'tab-indent-or-complete)
  (define-key company-active-map (kbd "TAB") 'tab-indent-or-complete))

(add-hook 'company-mode-hook 'bind-tab-properly)





(setq company-idle-delay 0)

(global-set-key (kbd "C-j") 'company-select-next-or-abort)
(global-set-key (kbd "C-k") 'company-select-previous-or-abort)
(define-key evil-insert-state-map (kbd "C-j") 'company-select-next-or-abort)
(define-key evil-insert-state-map (kbd "C-j") 'company-select-next-or-abort)
(define-key evil-insert-state-map (kbd "C-k") 'company-select-previous-or-abort)
