;;; Load monokai theme and set it
(prelude-require-package 'monokai-theme)
(load-theme 'monokai t)

;;Add resclient pacakge
(prelude-require-package 'restclient)

;;Add multiple cursors
(prelude-require-package 'multiple-cursors)
(global-set-key (kbd "\C-d") 'mc/mark-next-like-this)

;;map control p to finding a file with projectile
(define-key evil-normal-state-map "\C-p" 'projectile-switch-project)
(define-key evil-insert-state-map "\C-p" 'projectile-switch-project)
(define-key evil-visual-state-map "\C-p" 'projectile-switch-project)

;;REMAPu alt p to switching a project with projectile
(define-key evil-normal-state-map "\M-p" 'projectile-switch-project)
(define-key evil-insert-state-map "\M-p" 'projectile-switch-project)
(define-key evil-visual-state-map "\M-p" 'projectile-switch-project)
