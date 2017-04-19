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
(require 'browse-kill-ring)

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

;; browse kill ring
(key-chord-define-global "yy" 'browse-kill-ring)

;; shortcut for M-x is nice
(key-chord-define-global "xx" 'counsel-M-x)

;; multiple cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)

;; comment lines out with cmd + /
(global-set-key (kbd "s-/") 'comment-dwim-2)
(global-set-key (kbd "C-c /") 'comment-dwim-2)

;; expand current line into selection
(global-set-key (kbd "C-=") 'er/expand-region)

;; maximize the window with cmd + enter
(global-set-key (kbd "<s-return>") 'toggle-frame-maximized)

;; if there are two open buffers (split window) use cmd + w to switch between
(global-set-key (kbd "s-w") 'ace-window)

;; crux: https://github.com/bbatsov/crux
;;
;;Insert an empty line above the current line and indent it properly.
(global-set-key (kbd "<C-S-return>") 'crux-smart-open-line-above)

;; Insert an empty line and indent it properly (as in most IDEs).
(global-set-key [(shift return)] #'crux-smart-open-line)

;; Fix indentation in buffer and strip whitespace.
(global-set-key (kbd "C-c n") 'crux-cleanup-buffer-or-region)

;; Delete current file and buffer.
(global-set-key (kbd "C-c D") 'crux-delete-file-and-buffer)

;; Duplicate the current line (or region).
(global-set-key (kbd "C-c d") 'crux-duplicate-current-line-or-region)

;; Duplicate and comment the current line (or region).
(global-set-key (kbd "C-c M-d") 'crux-duplicate-and-comment-current-line-or-region)

;; Rename the current buffer and its visiting file if any.
(global-set-key (kbd "C-c r") 'crux-rename-buffer-and-file)

;; swap the content of the two windows. Left side goes to right. Right side goes
;; to left.
(global-set-key (kbd "C-c s") 'crux-swap-windows)

;; Kill whole line OR region
(defun frontmacs-kill-region-or-line ()
  "Kill the region if active. Else, kill the line."
  (interactive)
  (if (use-region-p)
      (call-interactively 'kill-region)
    (call-interactively 'crux-kill-whole-line)))

(global-set-key (kbd "C-w") 'frontmacs-kill-region-or-line)

;; Open current line or region in Github
(global-set-key (kbd "C-x v b") #'git-link)

;; Fire up the git time machine
;; https://github.com/pidu/git-timemachine
(global-set-key (kbd "C-x v t") 'git-timemachine)

;; Counsel provides some nice enhancements to core emacs functions.
;; See https://github.com/abo-abo/swiper#counsel for details

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
(global-set-key (kbd "C-h b") 'counsel-descbinds)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(provide 'frontmacs-keys)

;;; frontmacs-keys.el ends here
