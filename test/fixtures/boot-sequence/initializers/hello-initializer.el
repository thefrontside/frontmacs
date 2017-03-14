;; -*- eval: (flycheck-mode -1) -*-
(require 'dash)

(unless (boundp 't/boot-sequence)
  (error "fixture configuration script did not run"))

(setq t/boot-sequence (-concat t/boot-sequence (list
                                                :hello "initializer"
                                                :done (featurep 'frontmacs))))
