(require 'f)
(require 'shut-up)

(defvar t/user-emacs-directory (f-join load-file-name "../../build/tests.emacs.d"))
(defvar t/fixtures-directory (f-join load-file-name "../fixtures"))

(describe "configuration and initialization"
  :var (original-user-emacs-directory)
  (before-each
   (setq original-user-emacs-directory user-emacs-directory)
    ; Unload the frontmacs library, then cleanup and setup the sandboxed .emacs.d
    (when (featurep 'frontmacs)
      (unload-feature 'frontmacs t)
      (unload-feature 'frontmacs-config t))

    (when (f-exists? t/user-emacs-directory)
      (f-delete t/user-emacs-directory t))

    (f-mkdir t/user-emacs-directory)
    (setq user-emacs-directory t/user-emacs-directory)

    (custom-set-variables
     '(frontmacs-theme nil)))
  (after-each
   (setq user-emacs-directory original-user-emacs-directory))

  (describe "directory creation"
    (before-each
      (shut-up (require 'frontmacs)))

    (it "happens automatically"
      (expect (f-exists? (f-join user-emacs-directory "config.el")) :to-be-truthy)
      (expect (f-exists? (f-join user-emacs-directory "initializers")) :to-be-truthy)
      (expect (f-exists? (f-join user-emacs-directory "data")) :to-be-truthy)))

  (describe "bootup sequence"
    (before-each
      (f-copy-contents (f-join t/fixtures-directory "boot-sequence") t/user-emacs-directory)
      (shut-up (require 'frontmacs)))

    (it "runs the config, then the library, then the initializers"
        ;; it should have run fixtures/boot-sequence/hello-config.el first
        ;; then it should have run fixtures/boot-sequence/hello-initializer.el
        ;; the configuration should be run after `frontside-config' is finished,
        ;; but the rest of the library has not loaded, where as the initializers are
        ;; run after the entire `frontmacs' library is loaded
        (expect (boundp 't/boot-sequence) :to-be-truthy)
        (expect t/boot-sequence :to-equal (list
                                             :hello "config"
                                             :file frontmacs-config-file
                                             :done nil
                                             :hello "initializer"
                                             :done t)))))
