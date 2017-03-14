;; -*- eval: (flycheck-mode -1) -*-
(require 'f)
(add-to-list 'load-path default-directory)

(defvar t/fixtures-directory (f-join load-file-name "../fixtures"))
(defvar t/user-emacs-directory (f-join load-file-name "../../build/tests.emacs.d"))

(defun t/setup()
  "Unload the frontmacs library, then cleanup and setup the sandboxed .emacs.d"
  (when (featurep 'frontmacs)
    (unload-feature 'frontmacs t)
    (unload-feature 'frontmacs-config t))

  (when (f-exists? t/user-emacs-directory)
    (f-delete t/user-emacs-directory t))

  (f-mkdir t/user-emacs-directory)
  (setq user-emacs-directory t/user-emacs-directory)

  (custom-set-variables
   '(frontmacs-theme nil)))

(defun t/fixture(path)
  "Get the absolute path of tests/fixtures/PATH"
  (f-join t/fixtures-directory path))
