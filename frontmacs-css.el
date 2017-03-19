;; setup color highlighting
(require 'rainbow-mode)
(rainbow-mode +1)

;; set indent to 2
(setq css-indent-offset 2)

(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))

;; setup scss mode
(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; turn off annoying auto-compile on save
(setq scss-compile-at-save nil)

(provide 'frontmacs-css)
