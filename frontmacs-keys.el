;;; frontmacs-keys.el --- Frontmacs: key bindings

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Emacs is all about the key bindings, and this is where we define
;; all keyboard related activities.

;;; Code:

(require 'key-chord)
(require 'crux)
(require 'multiple-cursors)
(require 'expand-region)
(require 'ace-window)
(require 'comment-dwim-2)

;; Enables the M-up, M-down, M-right, M-left keys in terminal mode.
(add-hook 'tty-setup-hook
          '(lambda ()
             (define-key function-key-map "\e[1;9A" [M-up])
             (define-key function-key-map "\e[1;9B" [M-down])
             (define-key function-key-map "\e[1;9C" [M-right])
             (define-key function-key-map "\e[1;9D" [M-left])))


;; turn on key-chord mode
(key-chord-mode +1)

;; set undo to cmd + z
(global-set-key (kbd "C-z") 'undo)

;; go to word
(key-chord-define-global "jj" 'avy-goto-word-1)

;; go to line
(key-chord-define-global "jl" 'avy-goto-line)

;; go back to previous buffer
(key-chord-define-global "JJ" 'crux-switch-to-previous-buffer)

;; undo
(key-chord-define-global "uu" 'undo-tree-visualize)

;; multiple cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)

;; duplicate lines
(global-set-key (kbd "C-c d") 'crux-duplicate-current-line-or-region)

;; clean up buffer (indent, remove whitespace)
(global-set-key (kbd "C-c n") 'crux-cleanup-buffer-or-region)

;; rename file
(global-set-key (kbd "C-c r") 'crux-rename-buffer-and-file)

;; kill whole line
(global-set-key (kbd "C-w") 'crux-kill-whole-line)

;; comment lines out with cmd + /
(global-set-key (kbd "s-/") 'comment-dwim-2)
(global-set-key (kbd "C-c /") 'comment-dwim-2)

;; expand current line into selection
(global-set-key (kbd "C-=") 'er/expand-region)

;; maximize the window with cmd + enter
(global-set-key (kbd "<s-return>") 'toggle-frame-maximized)

;; if there are two open buffers (split window) use cmd + w to switch between
(global-set-key (kbd "s-w") 'ace-window)

(provide 'frontmacs-keys)

;;; frontmacs-keys.el ends here
