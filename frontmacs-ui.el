;;; frontmacs-ui.el --- Basic UI elements
;;; Commentary:

;;; Code:


;; ;; the blinking cursor is nothing, but an annoyance
;; (blink-cursor-mode -1)

;; ;; disable the annoying bell ring
;; (setq ring-bell-function 'ignore)


;; ;; nice scrolling
;; (setq scroll-margin 0
;;       scroll-conservatively 100000
;;       scroll-preserve-screen-position 1)

;; ;; mode line settings
;; (line-number-mode t)
;; (column-number-mode t)
;; (size-indication-mode t)
;; ;; more useful frame title, that show either a file or a
;; ;; buffer name (if the buffer isn't visiting a file)
;; (setq frame-title-format
;;       '("" invocation-name " Frontmacs - " (:eval (if (buffer-file-name)
;;                                             (abbreviate-file-name (buffer-file-name))
;;                                           "%b"))))
;; (require 'smart-mode-line)
;; (setq sml/no-confirm-load-theme t)
;; ;; delegate theming to the currently active theme
;; (setq sml/theme nil)
;; (add-hook 'after-init-hook #'sml/setup)

;; ;; show the cursor when moving after big movements in the window
;; (require 'beacon)
;; (beacon-mode +1)

;; ;; show available keybindings after you start typing
;; (require 'which-key)
;; (which-key-mode +1)

(provide 'frontmacs-ui)
;;; frontmacs-ui.el ends here
