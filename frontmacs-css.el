;; setup color highlighting
(require 'rainbow-mode)
(rainbow-mode +1)

;; set indent to 2
(setq css-indent-offset 2)

(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.sass\\'" . css-mode))

(provide 'frontmacs-css)
