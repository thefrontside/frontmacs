(require 'dart-mode)
(require 'lsp-mode)

;; use lsp-mode for dart
(add-hook 'dart-mode-hook #'lsp)

(provide 'frontmacs-dart)
