(require 'swiper)
(require 'company)
(require 'counsel-projectile)

;; -- Ivy setup --
;; https://github.com/abo-abo/swiper
;; Ivy has a lot of different moving parts which can be unecessarily
;; confusing. There is (i think) Ivy, the completion system which is
;; just the low-level set of apis for turning text into a set of
;; matches. Then there is Swiper, the UI that interacts with matching
;; in the mini-buffer. And then finally, Counsel, which provides and
;; extends a bunch of core emacs commands. So Ivy, Swiper and Counsel,
;; are all packages that are part of the same system, so we'll refer
;; to them as Ivy from here on out, even though it might technically
;; refer to a sub-part.

;; Ivy will use flx for fuzzy matching and sorting if it's installed.
(require 'flx)

;; Ivy will use smex for the counsel-M-x (it's replacement for M-x) if
;; it is installed.
(require 'smex)

;; use Ivy mode for completion
(ivy-mode 1)
(setq projectile-completion-system 'ivy)
(counsel-projectile-mode)

;; Make the default completion mechanism a fuzzy search. However, you
;; don't really want to use fuzzy matching on lists that have content
;; with a lot of spaces (like documents), so disable for swiper.
(setq ivy-re-builders-alist
      '((swiper . ivy--regex-plus)
        (t . ivy--regex-fuzzy)))

;; setup company mode for autocomplete
(setq company-idle-delay 0.5)
(setq company-tooltip-limit 10)
(setq company-minimum-prefix-length 2)
;; invert the navigation direction if the the completion popup-isearch-match
;; is displayed on top (happens near the bottom of windows)
(setq company-tooltip-flip-when-above t)
(global-company-mode 1)

(provide 'frontmacs-completion)
