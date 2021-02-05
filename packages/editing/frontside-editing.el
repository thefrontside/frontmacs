;;; frontside-editing.el --- Enhanced out of the box experience for text editing -*-lexical-binding:t-*-

;; Copyright (C) 2021 The Frontside Software, Inc.
;; See LICENSE for details

;; Author: Frontside Engineering <engineering@frontside.com>
;; Version: 1.0.0
;; Package-Requires: ((emacs "26.1") (browse-kill-ring "0") (comment-dwim-2 "0") (editorconfig "0.8.1") (smartparens "1.11") (undo-tree "0.7.5") (volatile-highlights "1.11") (flycheck "31") (which-key "2.0.1") (multiple-cursors "1.4.0") (drag-stuff "0.3.0") (yasnippet "0.11.0") (key-chord "0") (crux "0") (use-package "2.4.1"))
;; Keywords: files, tools
;; URL: https://github.com/frontside/frontmacs

;;; Commentary:

;;; Code:

;;;###autoload
(defun frontside-editing ()
  "Make editing really nice by default."

  (eval-when-compile (package-initialize))

  (use-package editorconfig
    :config (editorconfig-mode 1))

  ;; Death to the tabs indeed!
  ;; https://github.com/bbatsov/prelude/blob/master/core/prelude-editor.el#L35-L44
  (setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
  (setq-default tab-width 8)            ;; but maintain correct appearance


  ;; smart tab behavior - indent or complete
  (setq tab-always-indent 'complete)

  ;; always end files with newlines
  (setq require-final-newline t)

  ;; setup smartparens to auto open and close pairs
  (use-package smartparens
    :config
    (require 'smartparens-config)
    (smartparens-global-mode 1))

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

  ;; undo visual tree
  (use-package undo-tree
    :config (global-undo-tree-mode 1)
    :chords ("uu" . undo-tree-visualize))

  (use-package browse-kill-ring
    :chords (("yy" . browse-kill-ring)))

  (use-package comment-dwim-2
    :bind (("s-/" . comment-dwim-2)
           ("C-c /" . comment-dwim-2)))

  (use-package crux
    :bind (("<C-S-return>" . crux-smart-open-line-above)
           ([(shift return)] . crux-smart-open-line)
           ([remap move-beginning-of-line] . crux-move-beginning-of-line)
           ("C-c n" . crux-cleanup-buffer-or-region)
           ("C-c D" . crux-delete-file-and-buffer)
           ("C-c d" . crux-duplicate-current-line-or-region)
           ("C-c M-d" . crux-duplicate-and-comment-current-line-or-region)
           ("C-c r" . crux-rename-buffer-and-file)
           ("C-c s" . crux-swap-windows)
           ("C-w" . frontside-editing--kill-region-or-line)))

  ;; visual feedback to some operations by highlighting portions
  ;; relating to the operations.
  (require 'volatile-highlights)
  (volatile-highlights-mode t)
  (vhl/define-extension 'undo-tree 'undo-tree-yank 'undo-tree-move)
  (vhl/install-extension 'undo-tree)


  ;; make the left fringe 2 pixels so the hl-diff indicators aren't so fat
  ;; leave the right fringe width at the default 8 pixels
  (require 'fringe)
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
  (use-package drag-stuff
    :config
    (drag-stuff-global-mode)
    (drag-stuff-define-keys)
    :bind (("M-n" . drag-stuff-down)
           ("M-p" . drag-stuff-up)))

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
  (fset 'yes-or-no-p 'y-or-n-p))


;; Kill whole line OR region
(defun frontside-editing--kill-region-or-line ()
  "Kill the region if active, otherwise kill the line."
  (interactive)
  (if (use-region-p)
      (call-interactively 'kill-region)
    (call-interactively 'crux-kill-whole-line)))

;; TODO

(provide 'frontside-editing)
;;; frontside-editing.el ends here
