;;; frontmacs.el --- Frontside config package for emacs

;;; Commentary:

;;; Code:
(require 'frontmacs-config)
(require 'frontmacs-style)
(require 'frontmacs-system)
(require 'frontmacs-projectile)
(require 'frontmacs-completion)
(require 'frontmacs-vcs)
(require 'frontmacs-windowing)
(require 'frontmacs-editing)
(require 'frontmacs-devel)
(require 'frontmacs-keys)
(require 'frontmacs-modeline)

;; different language modes
(require 'frontmacs-web)
(require 'frontmacs-javascript)
(require 'frontmacs-css)
(require 'frontmacs-ruby)
(require 'frontmacs-yaml)
(require 'frontmacs-markdown)

(provide 'frontmacs)
;;; frontmacs.el ends here
