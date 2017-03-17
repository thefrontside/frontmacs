(require 'swiper)
(require 'undo-tree) 

;; use Ivy mode for completion
(ivy-mode 1)

(setq projectile-completion-system 'ivy)

(global-set-key "\C-s" 'swiper)

;; undo visual tree
(global-undo-tree-mode 1)

;; go to project dir when selecting project
(custom-set-variables
 '(projectile-switch-project-action (quote projectile-dired)))

(provide 'frontmacs-completion)
