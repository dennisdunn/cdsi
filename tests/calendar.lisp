(in-package :cl-user)

(defpackage :cl-cdsi/tests/calendar
  (:use :cl
        :cl-cdsi/calendar
        :rove))

(in-package :cl-cdsi/tests/calendar)

(defvar *date-a* (make-date 2000 3 30))
(defvar *date-b* (make-date 2000 3 31))

(deftest parse-date
  (testing "Parse a date"
    (let ((dt (parse "02/29/2000")))
      (ok (= (cl-cdsi/calendar::year dt) 2000)))))

(deftest parse-interval
  (testing "Parse a interval"
    (let ((dt (car (parse "1000 years"))))
      (ok (eq (cl-cdsi/calendar::unit dt) :year)))))

(deftest are-equal
  (testing "Are two dates equal?"
    (ok (date= *date-a* *date-a*))))

(deftest are-less-than
  (testing "one date less than another?"
    (ok (date< *date-a* *date-b*))))
