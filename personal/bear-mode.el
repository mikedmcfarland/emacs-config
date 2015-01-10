(defun map-all-evil-states (keys action)
  "maps key combination to action for all evil modes"
  (define-key evil-normal-state-map keys action)
  (define-key evil-insert-state-map keys action)
  (define-key evil-visual-state-map keys action)
)

;;map control p to finding a file with projectile
(map-all-evil-states (kbd "C-p") 'projectile-find-file)

;;Remap alt p to switching a project with projectile
(map-all-evil-states (kbd "M-p") 'projectile-switch-project)
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

(map-all-evil-states (kbd "C-h") 'previous-buffer)
(map-all-evil-states (kbd "C-l") 'next-buffer)


(define-key evil-insert-state-map "k" #'cofi/maybe-exit)

(evil-define-command cofi/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "k")
    (let ((evt (read-event (format "Insert %c to exit insert state" ?j)
               nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt ?j))
    (delete-char -1)
    (set-buffer-modified-p modified)
    (push 'escape unread-command-events))
       (t (setq unread-command-events (append unread-command-events
                          (list evt))))))))

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

;;make sure nerd commenter is installed
(prelude-require-package 'evil-nerd-commenter)

(define-minor-mode bear-mode
  "a mode designed with bears in mind"
  :lighter " bear"
  :global 1
  :keymap (let ((map (make-sparse-keymap)))
            ;;comment lines with control /
            (define-key map (kbd "C-/") 'evilnc-comment-or-uncomment-lines)
            map))

(provide 'bear-mode)
