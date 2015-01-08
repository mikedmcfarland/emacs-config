;;Set up tern js completion/refactoring
(prelude-require-package 'tern)
(add-hook 'prelude-js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
  '(progn
     (prelude-require-package 'tern-auto-complete)
     (tern-ac-setup)))

;;Set tab width of javascript to be 2 spaces
(setq-default js-indent-level 2)
(setq-default js2-basic-offset 2)

;;better highlighting
(setq-default js2-highlight-level 3)
(setq-default js2-highlight-external-variables t)

(setq-default js2-include-jslint-globals)
(setq-default js2-include-node-externs)

;;we like harmony
(setq-default js2-language-version 200)
