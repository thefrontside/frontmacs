;;; frontside-system.el --- Optimize Emacs for your operating system️ -*-lexical-binding:t-*-

;; Copyright (C) 2021 The Frontside Software, Inc.
;; See LICENSE for details

;; Author: Frontside Engineering <engineering@frontside.com>
;; Version: 1.0.0
;; Package-Requires: ((emacs "25.1") (exec-path-from-shell "1.12"))
;; Keywords: files, tools
;; URL: https://github.com/frontside/frontmacs

;;; Commentary:

;;; Code:

;;;###autoload
(defun frontside-system()
  "Optimize Emacs for specific platform."


  (require 'exec-path-from-shell)
  (exec-path-from-shell-initialize)

  (setq gc-cons-threshold 50000000)
  (setq large-file-warning-threshold 100000000)

  (require 'tool-bar)
  (tool-bar-mode -1)

  ;; disable startup screen
  (setq inhibit-startup-screen t)

  (when (eq system-type 'darwin)
    ;; It's all in the Meta
    (setq ns-function-modifier 'hyper)

    (menu-bar-mode +1)

    ;; Enable emoji, and stop the UI from freezing when trying to display them.
    (if (fboundp 'set-fontset-font)
        (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)))

  (unless window-system
    (menu-bar-mode -1)))


(provide 'frontside-system)
;;; frontside-system.el ends here
