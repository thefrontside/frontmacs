(require 'dart-mode)
(require 'lsp-mode)

;; use lsp-mode for dart
(add-hook 'dart-mode-hook #'lsp)

;; teach projectile how to recognize a dart project (it's one that has
;; a pubspec.yml or BUILD file in its root)
(with-eval-after-load "projectile"
  (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
  (add-to-list 'projectile-project-root-files-bottom-up "BUILD"))

(provide 'frontmacs-dart)
