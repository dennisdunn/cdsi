(in-package :cl-user)

(defpackage :cdsi/tests/calendar
  (:use :cl
        :fiveam
        :cdsi.common
        :cdsi.calendar))

(in-package :cdsi/tests/calendar)

(def-suite* calendar :in cdsi/tests::cdsi) ; how do you export a suite from a package?

(defparameter *date-a* (make-date 2000 3 30))
(defparameter *date-b* (make-date 2000 3 31))

(test parsing-units-date
      (let ((dt (parse-date "3/30/2000")))
        (is (date= *date-a* dt))))

(test parsing-units-interval
      (let ((int (parse-interval "1000 years")))
        (is (eq (interval-unit (car int)) :year))))

(test comparison-functions-=
      (is (date= *date-a* *date-a*)))

(test comparison-functions-<
      (is (date< *date-a* *date-b*)))

(test business-rules-CALCDT-1
      (is (date= (parse-date "1/1/2003") (date+ (parse-date "1/1/2000") (parse-interval "3 years")))))

(test business-rules-CALCDT-2
      (is (date= (parse-date "7/1/2000") (date+ (parse-date "1/1/2000") (parse-interval "6 months"))))
      (is (date= (parse-date "5/1/2001") (date+ (parse-date "11/1/2000") (parse-interval "6 months")))))

(test business-rules-CALCDT-3
      (is (date= (parse-date "1/4/2000") (date+ (parse-date " 1/1/2000") (parse-interval "3 days"))))
      (is (date= (parse-date "1/22/2000") (date+ (parse-date "1/1/2000") (parse-interval "3 weeks"))))
      (is (date= (parse-date "3/7/2000") (date+ (parse-date "2/1/2000") (parse-interval "5 weeks"))))
      (is (date= (parse-date "3/8/2001") (date+ (parse-date "2/1/2001") (parse-interval "5 weeks")))))

(test business-rules-CALCDT-4
      (is (date= (parse-date "1/11/2000") (date+ (parse-date "1/15/2000") (parse-interval "- 4 days")))))

(test business-rules-CALCDT-5
      (is (date= (parse-date "10/1/2000") (date+ (parse-date "3/31/2000") (parse-interval "6 months")))))

(test business-rules-CALCDT-6
      (is (date= (parse-date "7/27/2000") (date+ (parse-date "1/31/2000") (parse-interval "6 months - 4 days")))))
