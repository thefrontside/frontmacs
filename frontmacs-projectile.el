(require 'f)
(require 'projectile)

(setq projectile-cache-file (f-join frontmacs-data-directory "projectile.cache"))
(projectile-global-mode t)

;; go to project dir when selecting project
(custom-set-variables
 '(projectile-switch-project-action (quote projectile-dired)))

(provide 'frontmacs-projectile)
