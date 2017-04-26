;;; frontmacs-style.el --- Setup how Emacs looks.
;;;
;;; Commentary:
;;;
;;; There are three thing that make a good editor good: Capability,
;;; Performance and Style.  Each of which is critical.  It's the last of
;;; these, Style, that this module is all about.
;;;
;;; Let's make it look good!
;;;
;;; Code:

(require 'package)

(when frontmacs-theme
  ;; `package-install' is finicky about getting passed a symbol. It
  ;; won't work with the string "zenburn-theme", only the symbol
  ;; 'zenburn-theme. Same thing with `load-theme'. That's why we have
  ;; to take `frontmacs-theme' which is a symbol, convert it to a
  ;; string, concat it with "-theme" and then convert it back to a
  ;; symbol via `intern'
  (let ((package-name (intern (concat (symbol-name frontmacs-theme) "-theme"))))

    ;; download the theme package if it is not installed
    (unless (package-installed-p package-name)
      (package-refresh-contents)
      (package-install package-name t))

    ;; load it!
    (load-theme frontmacs-theme t)))


(require 'page-break-lines)
(global-page-break-lines-mode)

(provide 'frontmacs-style)
;;; frontmacs-style.el ends here
