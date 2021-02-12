;;;; Conditional Skip
;;;; Determines if a target dose can be skipped.

(in-package :cl-cdsi)

(defun evaluate-conditional-skip (conf dose)
  "Logic Spec Section 6.2"
  dose)

;(defun evaluate-conditional-skip-sets (conf dose)
  ;"Logic Spec Table 6-11"
 ; (cond ((eq conf :and) (every (evaluate-conditional-skip-set conf dose)))
;	((eq conf :or) (some (evaluate-conditonal-skip-set conf dose)))))

;(defun evaluate-conditional-skip-set (conf dose)
;  t)

;(defun type-of-age (dob assessment-date dose)
  "Logic Spec Table 6-6"
 " Is the Conditional Skip End Age Date > Conditional Skip Reference Date
  ≥ Conditional Skip Begin Age Date?
  Use the pertusus standared series for testing."
;  t)
