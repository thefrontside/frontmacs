(require 'hlinum)
(require 'linum)

;; Split horizontally when opening a new window from a command
;; whenever possible.
(setq split-height-threshold nil)

(defun frontside-windowing-adjust-split-width-threshold ()
  "Change the value of `split-width-threshold' so that it will cause the screen
split once and only once.

For example, if the frame is 360 columns wide, then we want the
split-width-threshold to be 181. That way, when you split horizontally, the two
new windows will each be 180 columns wide, and sit just below the threshold.
"
  (setq split-width-threshold (+ 1 (/ (frame-width) 2))))

;; recaculate split-width-threshold with every change
(add-hook 'window-configuration-change-hook
          'frontside-windowing-adjust-split-width-threshold)

;; vertical split, switch window, and open next buffer
(defun frontmacs/vsplit-last-buffer ()
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-next-buffer))
(global-set-key (kbd "C-x 2") 'frontmacs/vsplit-last-buffer)

;; horizontal split, switch window, and open next buffer
(defun frontmacs/hsplit-last-buffer ()
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil)
  (switch-to-next-buffer))
(global-set-key (kbd "C-x 3") 'frontmacs/hsplit-last-buffer)

;; Line numbers
;; highlight the current line number
(hlinum-activate)
(setq linum-format " %3d ")

;; turn on line numbers in prog-mode
(add-hook 'prog-mode-hook 'linum-mode)

;; disable window-system in terminal mode
(unless window-system
  (menu-bar-mode -1))

; disable startup screen
(setq inhibit-startup-screen t)

;; use super (cmd) + arrow keys to switch between visible buffers
(require 'windmove)
(windmove-default-keybindings 'super)

;; War and scrollbars. what are they good for?
(require 'scroll-bar)
(scroll-bar-mode -1)

(provide 'frontmacs-windowing)
