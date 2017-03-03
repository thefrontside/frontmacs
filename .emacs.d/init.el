;;; init.el --- Frontside shared config
;;; Commentary:
;; Frontmacs is a frontside shared config for Emacs as a package

;; Require Emacs' package functionality
(require 'package)

;;; Code:

(when (getenv "FRONTMACS_RUNLOCAL")
  (add-to-list 'load-path default-directory))

;; Initialise the package system.
(package-initialize)

(require 'frontmacs)

;;; init.el ends here
