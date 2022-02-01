(require 'buttercup)

(buttercup-define-matcher-for-unary-function :to-be-enabled
    (lambda (mode)
      (let ($list)
        (mapc (lambda ($mode)
                (condition-case nil
                    (if (and (symbolp $mode) (symbol-value $mode))
                        (setq $list (cons $mode $list)))
                  (error nil)))
              minor-mode-list)
                                        ;(print $list)
        (seq-contains-p $list mode)
        ))
  :expect-match-phrase "Expected `%A' to be enabled, but it was not"
  :expect-mismatch-phrase "Exected `%A' not to be enabled, but it was")
