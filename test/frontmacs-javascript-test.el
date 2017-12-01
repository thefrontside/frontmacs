;; -*- eval: (flycheck-mode -1) -*-
(require 'frontmacs-javascript)
(require 'f)

(defvar t/javascript-js (f-join load-file-name "../fixtures/javascript.js"))
(defvar t/javascript-mjs (f-join load-file-name "../fixtures/javascript.mjs"))

(describe "frontmacs-javascript"
  (describe "when a .js file is opened"
    (before-each
     (find-file t/javascript-js))

    (it "loads rjsx-mode"
      (expect major-mode :to-be 'rjsx-mode))

  (describe "when a .mjs file is opened"
    (before-each
     (find-file t/javascript-mjs))

    (it "loads rjsx-mode"
      (expect major-mode :to-be 'rjsx-mode)))))
