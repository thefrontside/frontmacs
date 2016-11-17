;;; init.el --- Frontside shared config
;;; Commentary:
;; Frontmacs is a frontside shared config for Emacs as a package

(setq custom-file (expand-file-name "personal/custom.el" user-emacs-directory ))

;; Require Emacs' package functionality
(require 'package)

;;; Code:

;; Add the Melpa repository to the list of package sources
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;; Initialise the package system.
(package-initialize)

(unless (require 'quelpa nil t)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

;;; (quelpa '(frontmacs :fetcher url :url "file:///Users/robertdeluca/Projects/frontmacs/frontmacs.el" ))
(quelpa '(frontmacs :fetcher github :repo "thefrontside/frontmacs" ))

;;; init.el ends here
