;;; init-frontmacs.el -- Setup Emacs to initalize with Frontmacs
;;; Commentary:
;;;
;;; Frontmacs provides a lot of nice customizations, but there needs
;;; to be a bootstrap process by which to actually get it
;;; running.  This is that bootstrap.  The idea is that you just need to
;;; load this script inside your `init.el` and it will take care of
;;; adding the frontside package archive to your package config, and
;;; then also installing it if it is not installed.
;;;
;;; --- init.el
;;;   ;; boot frontmacs
;;;   (load (expand-file-name "init-frontmacs.el" user-emacs-directory))
;;;
;;; In fact, it might need to be the only line you'll ever need in
;;; your init file.
;;; Code:
(require 'package)
(require 'tls)


(package-initialize)

(setq package-archives
      '(("MELPA Stable" . "https://stable.melpa.org/packages/")
        ("MELPA" . "https://melpa.org/packages/")
        ("GNU" . "http://elpa.gnu.org/packages/"))
      package-archive-priorities
      '(("MELPA Stable" . 10)
        ("MELPA" . 5)
        ("GNU" . 0))
      package-pinned-packages
      '((js2-mode . "MELPA")))


;; It turns out that the way package.el connects to the server, it
;; doesn't send the servername by default. Apparently sending the
;; server you're trying to connect to is called SNI (Server Name
;; Indication). And it's a way to get around having a static IP
;; associated with an SSL certificate. This extends the list of
;; commands to pass the `-servername' option to openssl. So whereas it
;; would try:
;;
;;   openssl s_client -connect elpa.frontside.io:443 -no_ssl2 -ign_eof
;;
;; now it will also try
;;
;;   openssl s_client -connect elpa.frontside.io:443 -no_ssl2 -ign_eof -servername elpa.frontside.io
;;
;; In order to not do this, we have to pay Amazon $600/month for the
;; privilege of a static IP address. We laughed at the idea when
;; setting up the archive, but little did we know it would come back
;; to haunt us!!
(add-to-list 'tls-program "openssl s_client -connect %h:%p -no_ssl2 -ign_eof -servername %h" t)


;; add the frontside package archive to the list, but allow it to be
;; overridden with the FRONTMACS_ARCHIVE variable. This allows us to
;; point to a local directory in development.
(let ((archive (or (getenv "FRONTMACS_ARCHIVE") "https://elpa.frontside.io/")))
  (add-to-list 'package-archives (cons "frontside" archive) t))

;; if frontmacs is not installed yet, install it.
(unless (package-installed-p 'frontmacs)
  (package-refresh-contents)
  (package-install 'frontmacs t))

;; take it away frontmacs!
(require 'frontmacs)

(provide 'init-frontmacs)
;;; init-frontmacs.el ends here
