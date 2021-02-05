;;; frontside-windowing.el --- Provide a consisent windowing and window splitting experience -*-lexical-binding:t-*-

;; Copyright (C) 2021 The Frontside Software, Inc.
;; See LICENSE for details

;; Author: Frontside Engineering <engineering@frontside.com>
;; Version: 1.0.0
;; Package-Requires: ((emacs "26.1") )
;; Keywords: files, tools
;; URL: https://github.com/frontside/frontmacs

;;; Commentary:

;;; Code:

;;;###autoload
(defun frontside-windowing()
  "Make working with windows consistent."

  (add-hook 'prog-mode-hook 'display-line-numbers-mode)
  (add-hook 'prog-mode-hook 'column-number-mode)

  ;; Split horizontally when opening a new window from a command
  ;; whenever possible.
  (setq split-height-threshold nil)

  ;; recaculate split-width-threshold with every change
  (add-hook 'window-configuration-change-hook
            #'frontside-windowing--window-configuration-change-hook)

  (global-set-key (kbd "C-x 2") #'frontside-windowing--vsplit-last-buffer)
  (global-set-key (kbd "C-x 3") #'frontside-windowing--hsplit-last-buffer)

  ;; disable window-system in terminal mode
  (unless window-system
    (menu-bar-mode -1))

  ; disable startup screen
  (setq inhibit-startup-screen t)

  ;; use super (cmd) + arrow keys to switch between visible buffers
  (require 'windmove)
  (windmove-default-keybindings 'super)

  ;; Emacs provides its own scrollbars for everything. There is _zero_
  ;; reason to have native scrollbars.
  (require 'scroll-bar)
  (scroll-bar-mode -1))

(defun frontside-windowing--window-configuration-change-hook ()
  "Set the `split-width-threshold' so that the screen only splits once.

For example, if the frame is 360 columns wide, then we want the
`split-width-threshold' to be 181. That way, when you split
horizontally, the two new windows will each be 180 columns wide, and
sit just below the threshold."
  (setq split-width-threshold (+ 1 (/ (frame-width) 2))))

(defun frontside-windowing--vsplit-last-buffer ()
  "Vertically split the screen, and open the next buffer in the new window."
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-next-buffer))


(defun frontside-windowing--hsplit-last-buffer ()
  "Horizonally split the screen, and open the next buffer in the new window."
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil)
  (switch-to-next-buffer))

(provide 'frontside-windowing)
;;; frontside-windowing.el ends here
