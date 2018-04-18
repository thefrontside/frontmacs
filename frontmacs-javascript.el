(require 'js2-mode)
(require 'rjsx-mode)
(require 'js2-refactor)
(require 'js-doc)

;; use rjsx-mode for all JS files
(add-to-list 'auto-mode-alist '("\\.js\\'"    . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.mjs\\'"    . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.pac\\'"   . rjsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . rjsx-mode))

;; We use js2r-refactor-mode which implies using js2-mode.
;; see https://github.com/magnars/js2-refactor.el
;;
;; all refactorings start with C-c C-r (for refactor!)
(js2r-add-keybindings-with-prefix "C-c C-r")
(add-hook 'js2-mode-hook 'js2-refactor-mode)

;; 2 space tab width
(custom-set-variables '(js-indent-level 2)
                      '(js2-basic-offset 2))

;; disable js2-mode warnings and errors since we'll use eslint
;; by default.
(custom-set-variables '(js2-mode-show-parse-errors nil)
                      '(js2-mode-show-strict-warnings nil))

;; setup jsdoc: https://github.com/mooz/js-doc
;;
;; We use the same prefix for js2r `C-c C-r' because it's an "advanced"
;; refactory-y type thing. The additional `i' prefix is for "insert"
(define-key js2-refactor-mode-map (kbd "C-c C-r i d") #'js-doc-insert-function-doc)
(define-key js2-refactor-mode-map "@" #'js-doc-insert-tag)

;; TypeScript:
;;
;; setup tide mode, the typescript IDE for Emacs
;; This is lifted straight from the suggested setup on the TIDE
;; README https://github.com/ananthakumaran/tide
(defun fs/setup-tide-mode()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(add-hook 'typescript-mode-hook #'fs/setup-tide-mode)

;; setup formatting options. The full list can be found at
;; https://github.com/Microsoft/TypeScript/blob/87e9506/src/services/services.ts#L1244-L1272
(setq tide-format-options
      '(:indentSize 2 :tabSize 2))


;;; parse node.js stack traces in compilation buffer.s
(require 'compile)
(add-to-list 'compilation-error-regexp-alist 'node)
(add-to-list 'compilation-error-regexp-alist-alist
             '(node "^[[:blank:]]*at \\(.*(\\|\\)\\(.+?\\):\\([[:digit:]]+\\):\\([[:digit:]]+\\)" 2 3 4))

;;; Specific versions of node packages installed on a per-project
;;; basis are the norm in JS development. So, for example, if you're
;;; using `eslint' to stylecheck your code, this will make project
;;; buffers find `node_modules/.bin/eslint' before any other
;;; executable in their `exec-path'
(require 'add-node-modules-path)
(add-hook 'prog-mode-hook #'add-node-modules-path)

(provide 'frontmacs-javascript)
;;; frontmacs-javascript.el ends here
