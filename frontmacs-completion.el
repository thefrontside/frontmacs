(require 'swiper)
(require 'company)

;; use Ivy mode for completion
(ivy-mode 1)
(setq projectile-completion-system 'ivy)
(global-set-key "\C-s" 'swiper)

;; setup company mode for autocomplete
(setq company-idle-delay 0.5)
(setq company-tooltip-limit 10)
(setq company-minimum-prefix-length 2)
;; invert the navigation direction if the the completion popup-isearch-match
;; is displayed on top (happens near the bottom of windows)
(setq company-tooltip-flip-when-above t)
(global-company-mode 1)

(provide 'frontmacs-completion)
