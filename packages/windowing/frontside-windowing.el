;;; frontside-windowing.el --- Consistent windowing and window splitting experience
;; -*-lexical-binding:t-*-

;; Copyright (C) 2021 The Frontside Software, Inc.
;; See LICENSE for details

;; Author: Frontside Engineering <engineering@frontside.com>
;; Version: 1.0.0
;; Package-Requires: ((emacs "26.1") )
;; Keywords: files, tools
;; URL: https://github.com/frontside/frontmacs/packages/windowing

;;; Commentary:
;;
;; Make window navigation consistent and intuitive.
;;
;; 1. It's annoying when you're using a lot of multi-window flows and commands
;; that render their output in a separate window are constantly either
;; splitting horizontally, or sometimes they open above, or sometimes they
;; open above.
;;
;; This makes the split consisent by always splitting horizontally by half.
;;
;; 2. Add keybindings so that window navigation works similar to tabbed navigation
;; 3. Aesthetic fixes such as removing double-rendered scroll bars

;;; Code:
(require 'windmove)
(require 'scroll-bar)

;;;###autoload
(defun frontside-windowing()
  "Make working with windows consistent."

  ;; Split horizontally when opening a new window from a command
  ;; whenever possible.
  (setq split-height-tHreshold nil)

  ;; recaculate split-width-threshold with every change
  (add-hook 'window-configuration-change-hook
            #'frontside-windowing--window-configuration-change-hook)

  (global-set-key (kbd "C-x 2") #'frontside-windowing--vsplit-last-buffer)
  (global-set-key (kbd "C-x 3") #'frontside-windowing--hsplit-last-buffer)

  ;; disable menu-bar in terminal mode
  (unless window-system
    (menu-bar-mode -1))

  ; disable startup screen
  (setq inhibit-startup-screen t)

  ;; use super (cmd) + arrow keys to switch between visible buffers
  (windmove-default-keybindings 'super)

  ;; Emacs provides its own scrollbars for everything. There is _zero_
  ;; reason to have native scrollbars.
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
