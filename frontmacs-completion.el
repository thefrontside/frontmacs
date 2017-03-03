(require 'ivy)
(require 'swiper)

(ivy-mode 1)
(setq projectile-completion-system 'ivy)
(global-set-key "\C-s" 'swiper)

(provide 'frontmacs-completion)
