;;; frontside-windowing-test.el --- Tests for frontside-javascript.

;;; Commentary:
;;
;; Test windows split correctly

;;; Code:

(require 'buttercup)

(describe "frontside-windowing"
  (before-all ;; arrange
    (require 'shut-up)
    (require 'frontside-windowing)
    (frontside-windowing))

  (before-each ;; act
    (set-frame-size (selected-frame) 800 600)
    (find-file "one.txt")
    (find-file "two.txt"))

  (describe "splitting the window vertically"
    (before-each ;; act
      (execute-kbd-macro (read-kbd-macro "C-x 3")))

    (it "switches to the newly opened window which has the most recent buffer" ;; assert
      (expect (buffer-name (current-buffer)) :to-equal "one.txt")))

  (describe "splitting the window horizontally"
    (before-each
      (execute-kbd-macro (read-kbd-macro "C-x 2")))

    (it "switches to the newly opened window which has the most recent buffer"
      (expect (buffer-name (current-buffer)) :to-equal "one.txt")))

  (describe "toggling frontside windowing-mode off"
    (before-each (frontside-windowing -1))
    (it "restores the value of split-height-threshold"
      (expect split-height-threshold :to-be 80))))

(provide 'frontside-javascript-test)
;;; frontside-windowing-test.el ends here
