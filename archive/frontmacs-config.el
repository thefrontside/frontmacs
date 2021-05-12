;;; frontmacs-config.el --- Frontmacs: configuration and storage.
;;;
;;; Commentary:
;;;
;;; This defines configuration variables for how Frontmacs will
;;; initialize.  The rough outline for booting is as follows:
;;;
;;; 1. load .emacs.d/config.el
;;; 2. load the rest of Frontmacs
;;; 3. load all of the elisp files in .emacs.d/initializers
;;;
;;; .emacs.d/config.el and .emacs.d/initalizers/ will be created for
;;; you if they don't exist already.
;;; Code:

(require 'f)

(defvar frontmacs-config-file (f-join user-emacs-directory "config.el")
  "Frontmacs configuration file.

Frontmacs defines configuration variables that customize how its intializers
will run.  This file will be loaded by frontmacs before it initializes so that
any values contained therein can be used by the initialization process

For example, you might want to set the `frontmacs-theme' variable from your
config in config.el:

  (custom-set-variables '(frontmacs-theme 'zenburn))

Note that these are only the configuration setttings that Frontmacs itself
exposes, and as a heavily curated system there may not be many.  For
configuration options that are not Frontmacs specific, use an initializer
instead")

(defvar frontmacs-initializers-directory (f-join user-emacs-directory "initializers")
  "All .el files in this directory will be run after Frontmacs initializes.

This is where you would do things like require custom modes and set them up, or
even write a bunch of custom elisp code.  When in doubt, it's usually safe to
put stuff in your initializers directory.")

(defvar frontmacs-data-directory (f-join user-emacs-directory "data")
  "This directory contains persistent application state.

The data directory is for storing things like autosave files and recent lists so
that they don't get pooped into things like your home directory or your init
file, but instead go to a well-known location.")

(defgroup frontmacs nil
  "Frontmacs Configuration"
  :prefix "frontmacs-"
  :group 'convenience)

(defcustom frontmacs-theme 'zenburn
  "Your personal theme."
  :type 'symbol
  :group 'frontmacs)

;; by default Emacs poops all customizations set through the
;; customization UI into your `init.el'. Let's not do that.
(setq custom-file (f-join frontmacs-data-directory "custom.el"))

;; create your config.el if it isn't created already
(unless (f-exists?  frontmacs-config-file)
  (f-write "
;; Frontmacs configuration
;;
(custom-set-variables
 ;; Change this in order to choose your theme. This will auto install your theme
 ;; as package with the suffix \"-theme\" appended to the end. So for example,
 ;; if your theme is set to 'twilight, then it will try and download and require
 ;; the 'twilight-theme ELPA package.
 ;;
 ;; If you want to have your own completely custom theme that isn't available as
 ;; as an ELPA package, then set this variable to `nil', and roll your own theme
 ;; in an initializer
 ;; '(frontmacs-theme 'zenburn)
 )
" 'utf-8 frontmacs-config-file))

;; create the initializers directory if it doesn't already exist.
(unless (f-exists? frontmacs-initializers-directory)
  (f-mkdir frontmacs-initializers-directory))

;; create the initializers directory if it doesn't already exist.
(unless (f-exists? frontmacs-data-directory)
  (f-mkdir frontmacs-data-directory))

;; load confi.el prior to the rest of initialization
(eval-after-load "frontmacs-config"
  '(load frontmacs-config-file))

;; load all of the files in the `initializers/' directory after
;; Frontmacs has fully loaded.
(eval-after-load "frontmacs"
  '(mapc 'load (directory-files frontmacs-initializers-directory 't "^[^#.].*el$")))

(provide 'frontmacs-config)
;;; frontmacs-config.el ends here
