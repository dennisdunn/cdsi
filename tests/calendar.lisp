(in-package :cl-cdsi/tests/calendar)

(defparameter *date-a* (cl-cdsi/calendar::make-date 2000 3 30))
(defparameter *date-b* (cl-cdsi/calendar::make-date 2000 3 31))

(deftest test-parsing-cdsi-calendar-units
         (testing "date"
                  (let ((dt (parse-date "02/29/2000")))
                    (ok (= (cl-cdsi/calendar::year dt) 2000))))

         (testing "interval"
                  (let ((int (parse-interval "1000 years")))
                  (ok (eq (cl-cdsi/calendar::unit (car int)) :year)))))

(deftest test-date-comparison-functions
         (testing "="
                  (ok (date= *date-a* *date-a*)))

         (testing "<"
                  (ok (date< *date-a* *date-b*))))

(deftest test-the-date-calculation-business-rules
         (testing "CALCDT-1"
                  (ok (date= (parse-date "1/1/2003") (date+ (parse-date "1/1/2000") (parse-interval "3 years")))))

(testing "CALCDT-2"
         (ok (date= (parse-date "7/1/2000") (date+ (parse-date "1/1/2000") (parse-interval "6 months"))))
         (ok (date= (parse-date "5/1/2001") (date+ (parse-date "11/1/2000") (parse-interval "6 months")))))

(testing "CALCDT-3"
         (ok (date= (parse-date "1/4/2000") (date+ (parse-date " 1/1/2000") (parse-interval "3 days"))))
         (ok (date= (parse-date "1/22/2000") (date+ (parse-date "1/1/2000") (parse-interval "3 weeks"))))
         (ok (date= (parse-date "3/7/2000") (date+ (parse-date "2/1/2000") (parse-interval "5 weeks"))))
         (ok (date= (parse-date "3/8/2001") (date+ (parse-date "2/1/2001") (parse-interval "5 weeks")))))

(testing "CALCDT-4"
         (ok (date= (parse-date "1/11/2000") (date+ (parse-date "1/15/2000") (parse-interval "- 4 days")))))

(testing "CALCDT-5"
         (ok (date= (parse-date "10/1/2000") (date+ (parse-date "3/31/2000") (parse-interval "6 months")))))

(testing "CALCDT-6"
         (ok (date= (parse-date "7/27/2000") (date+ (parse-date "1/31/2000") (parse-interval "6 months - 4 days"))))))
