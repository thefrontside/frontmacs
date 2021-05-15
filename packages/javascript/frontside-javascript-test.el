;;; frontside-javascript-test.el --- Tests for frontside-javascript.

;;; Commentary:
;;
;; Test that opening the various types of javascript files will all work

;;; Code:

(require 'buttercup)

(describe "frontside-javascript"
  (before-all
    (require 'shut-up)
    (require 'frontside-javascript)
    (frontside-javascript))

  (describe "opening a JS buffer"
    (before-each (find-file "myfile.js"))
    (it "loads rjsx-mode"
      (expect major-mode :to-be 'rjsx-mode))
    (describe "inserting some unformatted text and then formatting it"
      (before-each
        (shut-up
         (insert "{\nfoo: \"bar\"\n}")
         (activate-mark)
         (mark-whole-buffer)
         (indent-for-tab-command)))
      (it "requires this spec for the next one to pass 🤷" t)

      (it "indents to 2 spaces by default"
        (expect (buffer-substring 3 8) :to-equal "  foo"))))

  (describe "opening a JSX buffer"
    (before-each
      (find-file "myfile.jsx"))
    (it "loads rjsx-mode"
      (expect major-mode :to-be 'rjsx-mode)))

  (describe "opening a TS buffer"
    (before-each (shut-up (find-file "myfile.ts")))
    (it "loads typescript mode and tide"
      (expect major-mode :to-be 'typescript-mode)))

  (describe "opening a TSX buffer"
    (before-each (shut-up (find-file "myfile.tsx")))
    (it "uses web mode"
      (expect major-mode :to-be 'web-mode))
    (it "sets up tide as a minor mode within web-mode"
      (expect minor-mode-list :to-contain 'tide-mode))))

(provide 'frontside-javascript-test)
;;; frontside-javascript-test.el ends here
