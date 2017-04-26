(require 'f)

;; Have projectile persist its state into the data/ directory.
(setq projectile-cache-file (f-join frontmacs-data-directory "projectile.cache"))
(setq projectile-known-projects-file (f-join frontmacs-data-directory "projectile-bookmarks.eld"))

;; require projectile _after_ the configuration has been set so that it initializes
;; itself properly
(require 'projectile)

;; turn on projectile everywhere
(projectile-global-mode t)

;; go to project dir when selecting project
(custom-set-variables
 '(projectile-switch-project-action (quote projectile-dired)))

(provide 'frontmacs-projectile)
