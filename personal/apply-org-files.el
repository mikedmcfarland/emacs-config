;;Load emacs personal settings via org
(prelude-require-package 'org)
(org-babel-load-file
 (expand-file-name "personal/settings.org" user-emacs-directory))
