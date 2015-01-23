;;Set up tern js completion/refactoring
(prelude-require-package 'js2-refactor)
(js2r-add-keybindings-with-prefix (kbd "C-c C-r"))
(map-all-evil-states (kbd "C-S-r") 'js2r-rename-var)

;; (prelude-require-package 'tern)
;; (add-hook 'prelude-js-mode-hook (lambda () (tern-mode t)))
;; (eval-after-load 'tern
;;   '(progn
;;      (prelude-require-package 'tern-auto-complete)
;;      (tern-ac-setup)))

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

(defun js-jump-to (current from to format-name)
  (find-file
   (cl-loop with parts = (reverse current)
            with fname = (file-name-sans-extension (cl-first parts))
            for (name . rest) on (cl-rest parts)
            until (string-equal name from)
            collect name into names
            finally (cl-return
                     (mapconcat 'identity
                                (nconc (reverse rest)
                                       (list to)
                                       (reverse names)
                                       (list (funcall format-name fname) )) "/" )))))

(defun js-format-impl-name (fname)
  (format "%s.js" (replace-regexp-in-string "Spec" "" fname)))

(defun js-format-test-name (fname)
  (format "%sSpec.js" fname))

(defun js-jump-to-implementation-or-test ()
  (interactive)
  (let ((current (split-string (buffer-file-name) "/")))
    (cond
     ((member "test" current) (js-jump-to current "test" "lib" 'js-format-impl-name))
     ((member "lib" current)  (js-jump-to current "lib" "test" 'js-format-test-name))
     (t (error "not within a test or lib directory"))
  )))

(map-all-evil-states (kbd "C-t") 'js-jump-to-implementation-or-test)

(map-all-evil-states (kbd "C-S-l") 'js2r-log-this)
