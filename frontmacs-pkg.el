;; -*- eval: (flycheck-mode -1) -*-
(define-package "frontmacs" "0.1.5" "Frontside config package for emacs"
  '((f "0.19.0")
    (magit "2.8.0")
    (swiper "0.7.0")
    (projectile "0.13.0")
    (ag "0.4.7")
    (exec-path-from-shell "1.11")
    (page-break-lines "0.11")
    (drag-stuff "0.3.0")))

  :keywords '("emacs" "awesome" "starterkit")

  :authors '(("Charles Lowell" . "cowboyd@frontside.io")
             ("Robert Deluca" . "robertdeluca@frontside.io"))

  :maintainer '("Frontside" . "admin@frontside.io")))
