;;;; Tests of the date/time manipulation funcitons.

(in-package #:cl-cdsi/tests)

(def-suite date-time-tests
           :description "Test the date/time parsing and arithmetic functions."
           :in all-tests)

(in-suite date-time-tests)

(local-time:enable-read-macros)

(defun list-equal (a b)
  "Return T iff both lists have the same element in the corresponding position."
  (reduce #'eq (mapcar (lambda (item1 item2)
                         (if (and (listp item1) (listp item2))
                           (list-equal item1 item2)
                           (equal a b))) a b) :initial-value t))

(test parse-datetime-strings
      (is (local-time:timestamp= (cl-cdsi/util:parse-date "1/1/2020") @2020-01-01))
      (is (local-time:timestamp= (cl-cdsi/util:parse-date "12/31/2020") @2020-12-31))
      (is (local-time:timestamp= (cl-cdsi/util:parse-date "2/29/2020") @2020-02-29))
      (is (local-time:timestamp= (cl-cdsi/util:parse-date "2/28/2021") @2021-02-28))
      (is (local-time:timestamp= (cl-cdsi/util:parse-date "6/30/2020") @2020-06-30)))

(test parse-interval-strings
      (is (list-equal (cl-cdsi/util:parse-intervals "65 years") '((:amount 65 :unit :years))))
      (is (list-equal (cl-cdsi/util:parse-intervals "18 years - 4 days") '((:amount 18 :unit :years) (:amount -4 :unit :days))))
      (is (list-equal (cl-cdsi/util:parse-intervals "18years-4days") '((:amount 18 :unit :years) (:amount -4 :unit :days)))))

(test adjust-dates
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "1 years" "1/1/2020") @2021-01-01))
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "1 years - 1 day" "1/1/2020") @2020-12-31))
      (is (local-time:timestamp= (cl-cdsi/util:parse-and-adjust "1 years - 2 weeks" "1/1/2020") @2020-12-18)))

