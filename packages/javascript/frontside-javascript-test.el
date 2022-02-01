;;; -*- lexical-binding: t -*-
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
        (expect (buffer-substring 3 8) :to-equal "  foo")))
    (it "does not load lsp-mode"
      (expect 'lsp-mode :not :to-be-enabled)))

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
      (expect minor-mode-list :to-contain 'tide-mode)))

  (describe "deno project development"
    :var ((deno-project-root (expand-file-name "fixtures/deno-project")))
    (before-all
      (lsp-workspace-folders-add deno-project-root))
    (it "can find the fixture"
      (expect (file-exists-p (expand-file-name "deno.json" deno-project-root)) :to-be t))
    (describe "opening a javascript file"
      (before-each
        (shut-up (find-file (expand-file-name "js-file.js" deno-project-root))))
      (it "loads lsp-mode, not js2-refactor-mode"
        (expect 'lsp-mode :to-be-enabled)
        (expect 'js2-refactor-mode :not :to-be-enabled)))
    (describe "opening a typescript file"
      (before-each
        (shut-up (find-file (expand-file-name "ts-file.ts" deno-project-root))))
      (it "loads lsp-mode, not tide"
        (expect 'lsp-mode :to-be-enabled)
        (expect 'tide-mode :not :to-be-enabled)))
    (describe "opening a TSX file"
      (before-each
        (shut-up (find-file (expand-file-name "tsx-file.tsx" deno-project-root))))
      (it "loads lsp-mode, not tide"
        (expect 'lsp-mode :to-be-enabled)
        (expect 'tide-mode :not :to-be-enabled)))
    (describe "opening a JSX file"
      (before-each
        (shut-up (find-file (expand-file-name "jsx-file.jsx" deno-project-root))))
      (it "loads lsp-mode, not tide"
        (expect 'lsp-mode :to-be-enabled)
        (expect 'tide-mode :not :to-be-enabled)))))

(provide 'frontside-javascript-test)
;;; frontside-javascript-test.el ends here
