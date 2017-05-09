(defun frontmacs/setup-tide-mode ()
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'frontmacs/setup-tide-mode)

;; use rjsx-mode for all JS files
;; (add-to-list 'auto-mode-alist '("\\.js\\'"    . rjsx-mode))
;; (add-to-list 'auto-mode-alist '("\\.pac\\'"   . rjsx-mode))
;; (add-to-list 'interpreter-mode-alist '("node" . rjsx-mode))

;; We use js2r-refactor-mode which implies using js2-mode.
;; see https://github.com/magnars/js2-refactor.el
;;
;; all refactorings start with C-c C-r (for refactor!)
;; (js2r-add-keybindings-with-prefix "C-c C-r")
;; (add-hook 'js2-mode-hook 'js2-refactor-mode)

;; ;; 2 space tab width
;; (custom-set-variables '(js-indent-level 2)
;;                       '(js2-basic-offset 2))

(provide 'frontmacs-typescript)
