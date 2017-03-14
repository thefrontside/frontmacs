(require 'f)

(ert-deftest it-creates-a-config-and-data-and-initializers-directory()
  "When you use Frontmacs, it will create a data directory for persistent state
that is managed by emacs extensions, and also a config directory for you to
control how it boots up."
  (t/setup)
  (shut-up (require 'frontmacs))

  (should (f-exists? (f-join user-emacs-directory "config.el")))
  (should (f-exists? (f-join user-emacs-directory "initializers")))
  (should (f-exists? (f-join user-emacs-directory "data"))))


(ert-deftest it-runs-config-then-initializer-scripts()
  "First, frontmacs variables are defined. Then, user config is run. Then
Frontmacs initializes, then user initializers are run."
  (t/setup)
  (f-copy-contents (t/fixture "boot-sequence") t/user-emacs-directory)
  (shut-up (require 'frontmacs))

  ;; it should have run fixtures/boot-sequence/hello-config.el first
  ;; then it should have run fixtures/boot-sequence/hello-initializer.el
  ;; the configuration should be run after `frontside-config' is finished,
  ;; but the rest of the library has not loaded, where as the initializers are
  ;; run after the entire `frontmacs' library is loaded
  (should (boundp 't/boot-sequence))
  (should (equal (list
                  :hello "config"
                  :file frontmacs-config-file
                  :done nil
                  :hello "initializer"
                  :done t) t/boot-sequence)))
