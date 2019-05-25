(require 'lsp-mode)
(require 'company-lsp)

;; normally lsp mode prompts you about where your root is
;; however, this will make it guess your project root
;; using projectile
(custom-set-variables '(lsp-auto-guess-root t))

(provide 'frontmacs-language-server)
