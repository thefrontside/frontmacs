(require 'js2-mode)
(require 'js2-refactor)
(require 'js-doc)

;; use rjsx-mode for all JS files
(add-to-list 'auto-mode-alist '("\\.js\\'"    . rjsx-mode))
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
             '(node "at.*(\\(.+?\\):\\([[:digit:]]+\\):\\([[:digit:]]+\\)" 1 2 3))


(provide 'frontmacs-javascript)
;;; frontmacs-javascript.el ends here
