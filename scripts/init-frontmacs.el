;;; init-frontmacs.el -- Setup Emacs to initalize with Frontmacs
;;; Commentary:
;;;
;;; Frontmacs provides a lot of nice customizations, but there needs
;;; to be a bootstrap process by which to actually get it
;;; running. This is that bootstrap. The idea is that you just need to
;;; load this script inside your `init.el` and it will take care of
;;; adding the frontside package archive to your package config, and
;;; then also installing it if it is not installed. E.g.
;;;
;;; --- init.el
;;;   (load "init-frontmacs.el")
;;;
;;; In fact, it might need to be the only line you'll ever need in
;;; your init file.
;;; Code:
(require 'package)

(package-initialize)

;; add the frontside package archive to the list, but allow it to be
;; overridden with the FRONTMACS_ARCHIVE variable. This allows us to
;; point to a local directory in development.
(let ((archive (or (getenv "FRONTMACS_ARCHIVE") "https://elpa.frontside.io/")))
  (add-to-list 'package-archives (cons "frontside" archive) t))

;; if frontmacs is not installed yet, install it.
(unless (package-installed-p 'frontmacs)
  (package-refresh-contents)
  (package-install 'frontmacs t))

;; take it away frontmacs!
(require 'frontmacs)

(provide 'init-frontmacs)
;;; init-frontmacs.el ends here
