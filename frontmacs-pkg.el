;; -*- eval: (flycheck-mode -1) -*-
(define-package "frontmacs" "0.1.2" "Frontside config package for emacs"
  '((magit "2.8.0")
    (swiper "0.7.0")
    (projectile "0.13.0")
    (exec-path-from-shell "1.11"))

  :keywords '("emacs" "awesome" "starterkit")

  :authors '(("Charles Lowell" . "cowboyd@frontside.io")
             ("Robert Deluca" . "robertdeluca@frontside.io"))

  :maintainer '("Frontside" . "admin@frontside.io")))
