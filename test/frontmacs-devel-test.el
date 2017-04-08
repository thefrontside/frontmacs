;; -*- eval: (flycheck-mode -1) -*-
(require 'frontmacs-devel)

(describe "opening a frontmacs issue from emacs"
  (before-each
    (spy-on 'browse-url)
    (switch-to-buffer "*test-buffer*"))

  (describe "when there is no region selected"
    (before-each
      (frontmacs/open-issue-on-frontmacs-repo))

    (it "browses to the repo's new issue tab"
      (expect 'browse-url :to-have-been-called-with "https://github.com/thefrontside/frontmacs/issues/new")))

  (describe "with a region selected"
    (before-each
      (insert "ignore-SOMETHING IS WRONG WITH MY FRONTMACS-ignore")
      (set-mark 8)
      (move-to-column 43)
      ;; for some reason use-region-p won't return true in test :(
      ;; so we have to stub it to be true.
      (spy-on 'use-region-p :and-return-value t)

      (frontmacs/open-issue-on-frontmacs-repo))

    (it "browses to the repo's new issue form and pre-fills the selection"
      (expect 'browse-url :to-have-been-called-with "https://github.com/thefrontside/frontmacs/issues/new?body=SOMETHING%20IS%20WRONG%20WITH%20MY%20FRONTMACS"))))
