;;; frontmacs-editing.el --- What happens when I edit things?

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Behaviors for when you edit things.

;;; Code:
(require 'diminish)
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
(diminish 'volatile-highlights-mode)

;; undo visual tree
(require 'undo-tree)
(global-undo-tree-mode 1)
(diminish 'undo-tree-mode)

;; setup flycheck to show on the right side of the buffer
(require 'flycheck)
(setq flycheck-indication-mode 'right-fringe)

;; make the flycheck arrow look like a little triagle.
;; but only do it when emacs runs in a window, not terminal
(when window-system
  (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
    [0 0 0 0 0 4 12 28 60 124 252 124 60 28 12 4 0 0 0 0]))

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

(provide 'frontmacs-editing)

;;; frontmacs-editing.el ends here
