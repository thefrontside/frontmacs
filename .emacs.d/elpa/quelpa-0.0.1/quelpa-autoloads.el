;;; quelpa-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "quelpa" "quelpa.el" (22574 10611 0 0))
;;; Generated autoloads from quelpa.el

(autoload 'quelpa-expand-recipe "quelpa" "\
Expand a given recipe name into full recipe.
If called interactively, let the user choose a recipe name and
insert the result into the current buffer.

\(fn RECIPE-NAME)" t nil)

(autoload 'quelpa-self-upgrade "quelpa" "\
Upgrade quelpa itself.
ARGS are additional options for the quelpa recipe.

\(fn &optional ARGS)" t nil)

(autoload 'quelpa-upgrade "quelpa" "\
Upgrade all packages found in `quelpa-cache'.
This provides an easy way to upgrade all the packages for which
the `quelpa' command has been run in the current Emacs session.

\(fn)" t nil)

(autoload 'quelpa "quelpa" "\
Build and install a package with quelpa.
ARG can be a package name (symbol) or a melpa recipe (list).
PLIST is a plist that may modify the build and/or fetch process.
If called interactively, `quelpa' will prompt for a MELPA package
to install.

When `quelpa' is called interactively with a prefix argument (e.g
C-u M-x quelpa) it will try to upgrade the given package even if
the global var `quelpa-upgrade-p' is set to nil.

\(fn ARG &rest PLIST)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; quelpa-autoloads.el ends here
