(in-package :cl-cdsi/tests)

(defvar *date-a* (cl-cdsi/date-math::make-date 2000 3 30))
(defvar *date-b* (cl-cdsi/date-math::make-date 2000 3 31))

(def-suite date-math
           :description "Tests of date arithmetic."
           :in all-tests)

(in-suite date-math)

(test parse-date
  "Parse a date"
  (let ((dt (cl-cdsi::parse "02/29/2000")))
    (is (= (cl-cdsi/date-math::year dt) 2000))))

(test parse-interval
  "Parse a interval"
  (let ((dt (cons(cl-cdsi::parse "1000 years"))))
    (is (eq (cl-cdsi/date-math::unit dt) :year))))

(test are-equal
  "Are two dates equal?"
  (is (date= *date-a* *date-a*)))

(test are-less-than
  "Is one date less than another?"
  (is (date< *date-a* *date-b*)))
