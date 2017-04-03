(require 'f)
(require 'projectile)

;; Have projectile persist its state into the data/ directory.
(setq projectile-cache-file (f-join frontmacs-data-directory "projectile.cache"))
(setq projectile-known-projects-file (f-join frontmacs-data-directory "projectile-bookmarks.eld"))

;; turn on projectile everywhere
(projectile-global-mode t)

;; go to project dir when selecting project
(custom-set-variables
 '(projectile-switch-project-action (quote projectile-dired)))

(provide 'frontmacs-projectile)
