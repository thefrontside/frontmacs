(require 'magit)
(require 'diff-hl-flydiff)

;; use diff-hl to add git difs in gutter
(setq diff-hl-draw-borders nil)
;; needed for Magit 2.4 or newer
;; see: https://github.com/dgutov/diff-hl#magit
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
(global-diff-hl-mode t)
(diff-hl-flydiff-mode)

;; keybindings for magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;; Open github links in the browser
(setq git-link-open-in-browser t)

(provide 'frontmacs-vcs)
