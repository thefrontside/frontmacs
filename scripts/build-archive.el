(require 'package-x)
(setq package-archive-upload-base (concat default-directory "dist/packages"))
(package-upload-file (concat default-directory "dist/frontmacs-0.1.0.tar"))
