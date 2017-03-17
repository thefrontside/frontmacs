;;; frontmacs-keys.el --- Frontmacs: key bindings

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Emacs is all about the key bindings, and this is where we define
;; all keyboard related activities.

;;; Code:
;; Enables the M-up, M-down, M-right, M-left keys in terminal mode.
(add-hook 'tty-setup-hook
          '(lambda ()
             (define-key function-key-map "\e[1;9A" [M-up])
             (define-key function-key-map "\e[1;9B" [M-down])
             (define-key function-key-map "\e[1;9C" [M-right])
             (define-key function-key-map "\e[1;9D" [M-left])))

(provide 'frontmacs-keys)

;;; frontmacs-keys.el ends here


