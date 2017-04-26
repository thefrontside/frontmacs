;;; frontmacs-modeline.el --- Setup our modeline.
;;;
;;; Commentary:
;;;
;;; The default Emacs modeline is lame to the point of not providing any useful
;;; information in a sufficiently customized Emacs. The goal is to make our
;;; modeline useful and beautiful (in that order)
;;;
;;; Code:

(require 'diminish)

;; Out of the box, Every single major and minor mode gets put onto the modeline
;; which clutters it up terribly. Using diminish we can hide or abbreviate modes
;; that don't contribute meaningfully to the high-level context.
;; see https://github.com/myrjola/diminish.el
(diminish 'ivy-mode)
(diminish 'company-mode)
(diminish 'smartparens-mode)
(diminish 'volatile-highlights-mode)
(diminish 'undo-tree-mode)
(diminish 'flycheck-mode)
(diminish 'drag-stuff-mode)
(diminish 'which-key-mode)
(diminish 'yas-minor-mode)
(diminish 'projectile-mode)
(diminish 'page-break-lines-mode)

(provide 'frontmacs-modeline)
;;; frontmacs-modeline.el ends here
