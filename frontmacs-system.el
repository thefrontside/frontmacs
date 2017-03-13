;;; frontmacs-system.el --- System level tuning
;;;
;;; Commentary:
;;;
;;; Some stuff is not really anything to do with editing or modifying
;;; code, but related to the performance of Emacs itself, or where it
;;; can find executables in the operating system, or how something will
;;; behave on a Mac vs a Linux or Windows box.  Those types of tweaks go
;;; here.
;;;
;;; This is ported from Prelude.
;;;   https://github.com/bbatsov/prelude/blob/master/core/prelude-osx.el
;;;
;;; Code:

;; forward function declarations eliminate warnings about whether a
;; function is defined.
(declare-function exec-path-from-shell-initialize "exec-path-from-shell.el")

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; OSX specific code
(when (eq system-type 'darwin)

  ;; On OS X Emacs doesn't use the shell PATH if it's not started from
  ;; the shell. Let's fix that:
  (require 'exec-path-from-shell)
  (exec-path-from-shell-initialize)

  ;; It's all in the Meta
  (setq ns-function-modifier 'hyper)

  ;; proced-mode doesn't work on OS X so we use vkill instead
  (autoload 'vkill "vkill" nil t)
  (global-set-key (kbd "C-x p") 'vkill)

  (menu-bar-mode +1)

  ;; Enable emoji, and stop the UI from freezing when trying to display them.
  (if (fboundp 'set-fontset-font)
      (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)))

(provide 'frontmacs-system)
;;; frontmacs-system.el ends here
