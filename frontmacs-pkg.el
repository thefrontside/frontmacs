;; -*- eval: (flycheck-mode -1) -*-
(define-package "frontmacs" "0.1.5" "Frontside config package for emacs"
  '((f "0.19.0")
    (magit "2.8.0")
    (swiper "0.7.0")
    (projectile "0.13.0")
    (ag "0.4.7")
    (exec-path-from-shell "1.11")
    (page-break-lines "0.11")
    (crux "0.3.0")
    (key-chord "20160227.438")
    (hlinum "20160521.2112")
    (undo-tree "0.6.5")
    (ace-window "0.9.0")
    (expand-region "0.11.0")
    (comment-dwim-2 "1.2.2")
    (multiple-cursors "1.4.0")
    (drag-stuff "0.3.0")))

  :keywords '("emacs" "awesome" "starterkit")

  :authors '(("Charles Lowell" . "cowboyd@frontside.io")
             ("Robert Deluca" . "robertdeluca@frontside.io"))

  :maintainer '("Frontside" . "admin@frontside.io")))
