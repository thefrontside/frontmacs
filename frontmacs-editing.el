;;; frontmacs-editing.el --- What happens when I edit things?

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Behaviors for when you edit things.

;;; Code:

;; Death to the tabs indeed!
;; https://github.com/bbatsov/prelude/blob/master/core/prelude-editor.el#L35-L44
(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 8)            ;; but maintain correct appearance


;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)

;; always end files with newlines
(setq require-final-newline t)

;; setup smartparens to auto open and close pairs
(require 'smartparens-config)
(smartparens-global-mode 1)

;; when you have a selection, typing text replaces it all.
(delete-selection-mode t)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; show matching paren
(require 'paren)
(setq show-paren-style 'parenthesis)
(show-paren-mode +1)

;; highlight current line
(global-hl-line-mode +1)

;; visual feedback to some operations by highlighting portions
;; relating to the operations.
(require 'volatile-highlights)
(volatile-highlights-mode t)

;; undo visual tree
(require 'undo-tree)
(global-undo-tree-mode 1)

;; make the left fringe 2 pixels so the hl-diff indicators aren't so fat
;; leave the right fringe width at the default 8 pixels
(fringe-mode '(2 . 8))

;; setup flycheck to show on the right side of the buffer
(require 'flycheck)
(setq flycheck-indication-mode 'right-fringe)

;; make the flycheck arrow look like an exclamation point.
;; but only do it when emacs runs in a window, not terminal
(when window-system
  (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
    [0 24 24 24 24 24 24 0 0 24 24 0 0 0 0 0 0]))

(add-hook 'prog-mode-hook 'flycheck-mode)

;; show whitespace
(require 'whitespace)
(whitespace-mode +1)

 ;; limit line length
(setq whitespace-line-column 80)
(setq whitespace-style '(face tabs empty trailing lines-tail))

;; remove trailing whitespace when saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; backup and autosave files go into the tmp directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; disable annoying blink-matching-paren
(setq blink-matching-paren nil)

;; disable the blinking cursor
(blink-cursor-mode -1)

;; Drag stuff around.
(require 'drag-stuff)
(drag-stuff-global-mode)
(drag-stuff-define-keys)

;; displays the key bindings following your
;; currently entered incomplete command (a prefix) in a popup
(require 'which-key)
(which-key-mode +1)

;; Yet another snippet library, which is awesome. Allows you to expand
;; commonly used code templates into your buffer. Use it everywhere!
;; see https://joaotavora.github.io/yasnippet/
(require 'yasnippet)
(yas-global-mode +1)

;; Emacs creates lockfiles to recognize when someone else is already
;; editing the same file as you.
;;
;; Ember-CLI doesn't know what to do with these lock files. One second
;; they are there and the next the lock file disappears. This causes
;; issues with Ember-CLI's livereload feature where you will commonly
;; get an error like:
;;
;; Error: ENOENT, no such file or directory '.../components/.#file-name.hbs'
;;
;; To solve this issue we set "create-lockfiles" to nil and it will no
;; longer create these lock files.
(setq create-lockfiles nil)

;; enable y/n answers so you don't have to type 'yes' on 'no'
;; for everything
(fset 'yes-or-no-p 'y-or-n-p)

;; Autosave when switching buffers, windows, or frames.
;; Note: Emacs has different concepts of buffers, windows and frames
;; than you might be used to.
;;
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Buffers-and-Windows.html
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Frames.html
(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-up (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-down (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-left (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-right (before other-window-now activate)
  (when buffer-file-name (save-buffer)))

(add-hook 'focus-out-hook (lambda () (when buffer-file-name (save-buffer))))

;; This makes indenting region and untabifying region work on the entire
;; buffer if no region is selected
;; https://github.com/bbatsov/crux#using-the-bundled-advices
(require 'crux)
(crux-with-region-or-buffer indent-region)
(crux-with-region-or-buffer untabify)

(provide 'frontmacs-editing)

;;; frontmacs-editing.el ends here
