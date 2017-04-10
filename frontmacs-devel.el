;;; frontmacs-devel --- Functions related to the development of Frontmacs itself.
;;
;;; Commentary:
;;
;; Sometimes the development that you're doing is on Frontmacs itself
;; and so this package contains handy functions for doing just that.
;;
;;; Code:

(defvar frontmacs-repository-new-issue-url "https://github.com/thefrontside/frontmacs/issues/new"
  "The URL at which to file new issues for Frontmacs itself.")

(defun frontmacs/open-issue-on-frontmacs-repo ()
  "Open up a new issue on the Frontmacs github repository.
If there is currently selected text, then that text will be used as
the body of the issue."
  (interactive)
  (if (use-region-p)
      (let ((text (url-encode-url (buffer-substring-no-properties (region-beginning) (region-end)))))
        (browse-url (concat frontmacs-repository-new-issue-url "?body=" text)))
    (browse-url frontmacs-repository-new-issue-url)))

(provide 'frontmacs-devel)
;;; frontmacs-devel.el ends here
