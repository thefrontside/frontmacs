;;; frontside-javascript.el --- JS  development that just work™️ -*-lexical-binding:t-*-

;; Copyright (C) 2021 The Frontside Software, Inc.
;; SPDX-License-Identifier: MIT

;; Author: Frontside Engineering <engineering@frontside.com>
;; Version: 1.0.0
;; Package-Requires: ((emacs "25.1") (add-node-modules-path "1.2.0") (company "0.9.2") (flycheck "20201228.2104") (js2-mode "20201220") (js2-refactor "0.9.0") (rjsx-mode "0.5.0") (tide "4.0.2") (web-mode "17") (lsp-mode "20220124"))
;; Keywords: files, tools
;; URL: https://github.com/thefrontside/frontmacs

;;; Commentary:

;; Modern JavaScript development can be complex.  With the rise of
;; transpilers such as Babel and TypeScript, the needs for editing,
;; testing, and building JavaScript are more difficult than ever.
;; While editors like VSCode come out of the box being robust tools
;; for working with JavaScript.  Emacs on the other hand is just flat
;; out broken by default.  The builitin js2-mode cannot even handle
;; modern syntax, and as a result it sprays errors and red underlines
;; all over the place.  To make matters worse, modern JS syntax is
;; extensible with tools like babel, and so it will never be able to
;; catch up with a one-size-fits-all solution.  Throw on top of
;; _that_, the fact that in the course of your average JS project,
;; you're likely to encounter not just `.js' files, but also `.jsx',
;; `.ts', and `.tsx' as well.  You don't want to have to wonder why
;; your editor is broken or stop to google for 2 hours just in order
;; to work with a JS project you just cloned from github.  What you
;; need is a setup that can handle whatever the JS ecosystem throws
;; at you.
;;
;; Enter `frontside-javascript'.  The goal is simple: any JavaScript
;; project you care to download you should just work straight away, no
;; matter if it contains TypeScript, React, Node, ES6, Deno, or
;; whatever; now and going forward.  By work, it means it should:
;;
;;   1. Be able to understand the syntax as defined by the project
;;      itself, not a global concept of JavaScript syntax.
;;   2. Highlight errors based ond the configured style of the
;;      project itself.
;;   3. Have completions, documentations, and refactoring at the
;;      current point based on the sources of the current project.
;;   4. find and navigate to symbolic references
;;
;; Usage:
;;
;; (frontside-javascript)
;;; Code:

(require 'lsp)
(require 'lsp-mode)
(require 'js2-mode)
(require 'js2-refactor)
(require 'rjsx-mode)
(require 'flycheck)
(require 'tide)
(require 'web-mode)
(require 'tide)
(require 'company)
(require 'compile)
(require 'add-node-modules-path)

;;;###autoload
(defun frontside-javascript()
  "Make Emacs have your back no matter what JavaScript project you'refaced with.
This is the main entry point which configures JS, JSX, TS, TSX, and NodeJS development"
  (interactive)

  (frontside-javascript--javascript)
  (frontside-javascript--typescript)
  (frontside-javascript--node))


(defun frontside-javascript--javascript()
  "Setup for working with JavaScript."

  ;; 2 space tab width
  (custom-set-default 'js-indent-level 2)
  (custom-set-default 'js2-basic-offset 2)

  ;; Use js2r-refactor-mode which implies using js2-mode.
  ;; see https://github.com/magnars/js2-refactor.el
  ;;
  ;; all refactorings start with C-c C-r (for refactor)
  (js2r-add-keybindings-with-prefix "C-c C-r")

  ;; use rjsx-mode for all JS files, since js-mode and js2-mode simply does not
  ;; cut it anymore.
  (add-to-list 'auto-mode-alist '("\\.js\\'"    . rjsx-mode))
  (add-to-list 'auto-mode-alist '("\\.mjs\\'"    . rjsx-mode))
  (add-to-list 'auto-mode-alist '("\\.pac\\'"   . rjsx-mode))

  (add-hook 'js2-mode-hook #'frontside-javascript--js2-mode-hook))

(defun frontside-javascript--js2-mode-hook()
  "Setup javascript buffers.
Since `rjsx-mode' is derived from `js2-mode' this will also run there."

  ;; Most projects use either eslint, prettier, or .editorconfig in
  ;; order to specify indent level and formatting. In the event that
  ;; no project-level config is specified (very rarely these days),
  ;; the community default is 2, not 4.
  (setq js-indent-level 2)
  (setq js2-basic-offset 2)

  (cond
   ;; If this is a Deno project, use lsp-mode
   ((frontside-javascript--deno-project-p)
    (lsp 1))

   ;; Otherwise, we use the old js2-refactor testup
   (t
    ;; setup js2-refactor mode in order to get symbol navigation and
    ;; renaming. Eventually, this will be relpaced with LSP.
    (js2-refactor-mode)


    ;; disable the default js2-mode errors and warnings since js2-mode
    ;; nowadays simply does not get the errors and warnings right.
    (setq js2-mode-show-parse-errors nil)
    (setq js2-mode-show-strict-warnings nil)

    ;; instead, make sure we're using flycheck
    (flycheck-mode +1))))


(defun frontside-javascript--typescript()
  "Setup working with TypeScript."


  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mdx\\'" . web-mode))


  (add-hook 'typescript-mode-hook #'frontside-javascript--typescript-mode-hook)
  (add-hook 'web-mode-hook #'frontside-javascript--tsx-web-mode-hook)

  ;; enable javascript-eslint checker to run after tide checkers. Tide checker
  ;; highlights syntax errors, and javascript eslint checker highlights linter
  ;; warnings
  ;; https://github.com/thefrontside/frontmacs/issues/156
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'typescript-mode)

  (flycheck-add-next-checker 'typescript-tide 'javascript-eslint)
  (flycheck-add-next-checker 'tsx-tide 'javascript-eslint)
  (flycheck-add-next-checker 'jsx-tide 'javascript-eslint))

(defun frontside-javascript--typescript-mode-hook()
  "Setup typescript buffers to use TIDE.
typescript-mode.el is very barebones, but the expectation around
  TypeScript is that you will have really great error highlighting,
  type-inspection, completion, symbol navigation, and project-wide
  refactorings.  Provide this with TIDE."

  ;; Most projects use either eslint, prettier, .editorconfig, or tsf in
  ;; order to specify indent level and formatting. In the event that
  ;; no project-level config is specified (very rarely these days),
  ;; the community default is 2, not 4. However, respect what is in
  ;; tsfmt.json if it is present in the project
  (setq typescript-indent-level
        (or (plist-get (tide-tsfmt-options) ':indentSize) 2))

  ;; use flycheck to highlight syntax errors.
  (flycheck-mode +1)

  (cond ((frontside-javascript--deno-project-p)
         (lsp))
        (t
         (tide-setup)


         ;; whenever you hover over a variable, show its type in the minibuffer
         (eldoc-mode +1)
         (tide-hl-identifier-mode +1)

         ;; enable completion. This is an expectation for typescript
         (company-mode +1)

         ;; Make TypesScript annotations look coherent when appearing in a
         ;; completion popup.
         (set (make-local-variable 'company-tooltip-align-annotations) t))))


(defun frontside-javascript--tsx-web-mode-hook()
  "Setup web mode for handling TSX.
There isn't anything like `rjsx-mode' for TypeScript, so instead of
using `typescript-mode' as the major mode (which loses its mind when it
sees TSX code), we use `web-mode', but load and configure TIDE in order
to enable refactoring."

  (when (string-equal "tsx" (file-name-extension buffer-file-name))
    (frontside-javascript--typescript-mode-hook)))


(defun frontside-javascript--node()
  "Make Emacs friendly for node develpment."

  ;; for shebang scripts that use node as the interpreter
  ;; use rjsx-mode
  (add-to-list 'interpreter-mode-alist '("node" . rjsx-mode))

  ;; parse node.js stack traces in compilation buffer.s
  (add-to-list 'compilation-error-regexp-alist 'node)
  (add-to-list 'compilation-error-regexp-alist-alist
               '(node "^[[:blank:]]*at \\(.*(\\|\\)\\(.+?\\):\\([[:digit:]]+\\):\\([[:digit:]]+\\)" 2 3 4))

  ;; Specific versions of node packages installed on a per-project
  ;; basis are the norm in JS development. So, for example, if you're
  ;; using `eslint' to stylecheck your code, this will make project
  ;; buffers find `node_modules/.bin/eslint' before any other
  ;; executable in their `exec-path'
  (add-hook 'prog-mode-hook #'add-node-modules-path))

(defun frontside-javascript--deno-project-p ()
  "Is the current file inside a deno project"
  (locate-dominating-file buffer-file-name "deno.json"))

;; Make it so that you only need to say `(use-package frontside-javascript)`
;;;###autoload
(setq use-package--frontside-javascript--pre-config-hook #'frontside-javascript)

(provide 'frontside-javascript)
;;; frontside-javascript.el ends here
