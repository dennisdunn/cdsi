;;;; conditional-skip tests

(def-suite conditional-skip
  :description "Tests the conditional-skip, section 6.2"
  :in all-tests)

(in-suite conditional-skip)

(defvar *series*)

(test check-api-connection
  (setf *series* (car (client:fetch "antigens/Pertussis/series?q=standard")))
  (is (not (null *series*)))
  (is (equal (getf *series* :series-name) "Pertussis standard series")))

