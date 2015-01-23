(defun map-all-evil-states (keys action)
  "maps key combination to action for all evil modes"
  (define-key evil-normal-state-map keys action)
  (define-key evil-insert-state-map keys action)
  (define-key evil-visual-state-map keys action)
)
;;map control p to finding a file with projectile
(map-all-evil-states (kbd "C-p") 'projectile-find-file)
(global-set-key (kbd "C-p") 'projectile-find-file)
;;Remap alt p to switching a project with projectile
(global-set-key (kbd "M-p") 'projectile-switch-project)
;;have j and k go down to next visual line
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;;Have no idea why up and down are doing absurd things, but this helped
(global-set-key (kbd "<up>") 'evil-previous-visual-line)
(global-set-key (kbd "<down>") 'evil-next-visual-line)
(global-set-key (kbd "C-h") 'previous-buffer)
(global-set-key (kbd "C-l") 'next-buffer)
(global-set-key (kbd "C-q") 'kill-this-buffer)
(map-all-evil-states (kbd "C-s") 'save-buffer)
(map-all-evil-states (kbd "C-n") 'xah-new-empty-buffer)
(map-all-evil-states (kbd "C-/") 'evilnc-comment-or-uncomment-lines)
(define-key evil-normal-state-map (kbd "gp") 'evil-select-last-yanked-text)

(defun evil-select-last-yanked-text ()
  "uses evils markers to select the last yanked text"
  (interactive)
  (evil-goto-mark ?\[)
  (evil-visual-char)
  (evil-goto-mark ?\]))

;;include expand region
(prelude-require-package 'expand-region)
(global-set-key (kbd "C-S-SPC") 'er/contract-region)
(global-set-key (kbd "C-SPC") 'er/expand-region)

;;Define KJ as espace while in insert
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

(defun xah-new-empty-buffer ()
  "Open a new empty buffer."
  (interactive)
  (let ((buf (generate-new-buffer "untitled")))
    (switch-to-buffer buf)
    (funcall (and initial-major-mode))
    (setq buffer-offer-save t)))


;; (define-minor-mode bear-mode
;;   "a mode designed with bears in mind"
;;   :lighter " bear"
;;   :global 1
;;   :keymap (let ((map (make-sparse-keymap)))
;;             ;;comment lines with control /
;;             (define-key map (kbd "C-p") nil)
;;             map))

;; (provide 'bear-mode)
