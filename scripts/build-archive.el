(require 'package-x)
(setq package-archive-upload-base (concat default-directory "dist/packages"))
(package-upload-file (car (file-expand-wildcards "dist/frontmacs-*.tar")))
