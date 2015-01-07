;;map control p to finding a file with projectile
(define-key evil-normal-state-map "\C-p" 'projectile-find-file)
(define-key evil-insert-state-map "\C-p" 'projectile-find-file)
(define-key evil-visual-state-map "\C-p" 'projectile-find-file)
;;Remap alt p to switching a project with projectile
(define-key evil-normal-state-map "\M-p" 'projectile-switch-project)
(define-key evil-insert-state-map "\M-p" 'projectile-switch-project)
(define-key evil-visual-state-map "\M-p" 'projectile-switch-project)
;;have j and k go down to next visual line
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
;;map coontrol j/k to do page up/ page down
(define-key evil-normal-state-map (kbd "C-k") (lambda ()
                    (interactive)
                    (evil-scroll-up nil)))
(define-key evil-normal-state-map (kbd "C-j") (lambda ()
                        (interactive)
                        (evil-scroll-down nil)))



;;Have escape actually exit things
;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

;;auto indent line on return
(define-key global-map (kbd "RET") 'newline-and-indent)

(define-minor-mode bear-mode
  "a mode designed with bears in mind"
  :lighter " bear"
  :global 1
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-/") 'evilnc-comment-or-uncomment-lines)
            map))

(provide 'bear-mode)
