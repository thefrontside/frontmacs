;;; frontmacs-editing.el --- What happens when I edit things?

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Behaviors for when you edit things.

;;; Code:
(require 'undo-tree)
(require 'flycheck)

;; Death to the tabs indeed!
;; https://github.com/bbatsov/prelude/blob/master/core/prelude-editor.el#L35-L44
(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 8)            ;; but maintain correct appearance


;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)

;; always end files with newlines
(setq require-final-newline t)

;; when you have a selection, typing text replaces it all.
(delete-selection-mode t)

;; undo visual tree
(global-undo-tree-mode 1)

;; setup flycheck
(setq flycheck-indication-mode 'right-fringe)
(define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
  [0 0 0 0 0 4 12 28 60 124 252 124 60 28 12 4 0 0 0 0])

(add-hook 'prog-mode-hook 'flycheck-mode)

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

;; Drag stuff around.
(require 'drag-stuff)
(drag-stuff-global-mode)
(drag-stuff-define-keys)

(provide 'frontmacs-editing)

;;; frontmacs-editing.el ends here
