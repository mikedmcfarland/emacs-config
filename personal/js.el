;;Set up tern js completion/refactoring
(prelude-require-package 'tern)
(add-hook 'prelude-js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
  '(progn
     (prelude-require-package 'tern-auto-complete)
     (tern-ac-setup)))

;;Set tab width of javascript to be 2 spaces
(setq-default js-indent-level 2)
(add-hook 'prelude-js-mode-hook
  (lambda() (setq evil-shift-width 2)))

(setq-default js2-basic-offset 2)
;;better highlighting
(setq-default js2-highlight-level 3)
(setq-default js2-highlight-external-variables t)
;;some default settings for js2
(setq-default js2-include-jslint-globals t)
(setq-default js2-include-node-externs t)
(setq-default js2-concat-multiline-strings t)
(setq-default js2-include-node-externs t)
(setq-default js2-strict-missing-semi-warning nil)
(setq-default js2-pretty-multiline-declarations nil)
;;we like harmony
(setq-default js2-language-version 200)
