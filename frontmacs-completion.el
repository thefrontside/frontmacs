(require 'swiper)

;; use Ivy mode for completion
(ivy-mode 1)

(setq projectile-completion-system 'ivy)

(global-set-key "\C-s" 'swiper)

(provide 'frontmacs-completion)
