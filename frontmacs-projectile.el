(require 'f)
(require 'projectile)

(setq projectile-cache-file (f-join frontmacs-data-directory "projectile.cache"))
(projectile-global-mode t)

(provide 'frontmacs-projectile)
