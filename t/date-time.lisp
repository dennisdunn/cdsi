(in-package #:cl-cdsi/tests)

(def-suite date-time-tests
           :description "Test the date/time parsing and arithmetic functions."
           :in all-tests)

(in-suite date-time-tests)

(defun list-equal (a b)
  "Return T iff both lists have the same element in the corresponding position."
  (reduce #'eq (mapcar (lambda (item1 item2)
                         (if (and (listp item1) (listp item2))
                           (list-equal item1 item2)
                           (equal a b))) a b) :initial-value t))

(defun parse (datestring)
  "Parses the datestring into a timestamp in the default timezone"
  (let ((offset (cl-cdsi/util::get-tz-offset)))
        (local-time:parse-timestring datestring :offset offset)))

(test parse-datetime-strings
      (is (local-time:timestamp= (cl-cdsi/util:parse-date "1/1/2020") (parse "2020-01-01")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-date "12/31/2020") (parse "2020-12-31")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-date "2/29/2020") (parse "2020-02-29")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-date "2/28/2021") (parse "2021-02-28")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-date "6/30/2020") (parse "2020-06-30"))))

(test parse-interval-strings
      (is (list-equal (cl-cdsi/util:parse-intervals "65 years") '((:amount 65 :unit :year))))
      (is (list-equal (cl-cdsi/util:parse-intervals "18 years - 4 days") '((:amount 18 :unit :year) (:amount -4 :unit :day))))
      (is (list-equal (cl-cdsi/util:parse-intervals "18years-4days") '((:amount 18 :unit :year) (:amount -4 :unit :day)))))

(test adjust-dates
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "1 years" "1/1/2020") (parse "2021-01-01")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "1 years - 1 day" "1/1/2020") (parse "2020-12-31")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "1 years - 2 weeks" "1/15/2020") (parse "2021-01-01"))))

(test cdsi-calcdate
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "3 years" "1/1/2000") (parse "2003-01-01")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "6 months" "1/1/2000") (parse "2000-07-01")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "6 months" "11/1/2000") (parse "2001-05-01")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "3 days" "1/1/2000") (parse "2000-01-04")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "3 weeks" "1/1/2000") (parse "2000-01-22")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "5 weeks" "2/1/2000") (parse "2000-03-07")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "5 weeks" "2/1/2001") (parse "2001-03-08")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "- 4 days" "1/15/2000") (parse "2000-01-11")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "6 months" "3/31/2000") (parse "2000-10-01")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "6 months" "8/31/2000") (parse "2001-03-01")))
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "+ 6 months - 4 days" "1/31/2000") (parse "2000-07-27"))))



