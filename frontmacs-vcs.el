(require 'magit)
(require 'diff-hl)

;; keybindings for magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;; use diff-hl to add git difs in gutter
(setq diff-hl-draw-borders nil)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
(global-diff-hl-mode +1)
(diff-hl-flydiff-mode)

(provide 'frontmacs-vcs)
