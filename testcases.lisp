(in-package :testcases)

(defparameter *data-files-location* #P"/home/owner/source/cdsi/cl-cdsi/data-files/testcases/")
(defparameter *fname* #P"cdsi-healthy-childhood-and-adult-test-cases-v4.8.csv")
(defparameter *headers* nil)
(defparameter *testcases* nil)

(defun get-testcase (id)
  (find-if #'(lambda (x) (equal id (testcase-id x))) *testcases*))

(defun get-assessment (id)
  (let ((testcase (get-testcase id)))
    (make-assessment :date (testcase-assessment-date testcase)
                     :patient (testcase-patient testcase)
                     :history (testcase-vaccine-history testcase))))

(defun read-testcases ()
  "Read the testcase file and return a list of testcases."
  (let ((filepath (merge-pathnames *data-files-location* *fname*)))
    (cl-csv:read-csv filepath :unquoted-empty-string-is-nil t
                     :trim-outer-whitespace t
                     :skip-first-p t
                     :map-fn #'row->testcase)))

(defun read-headers ()
  (let* ((filepath (merge-pathnames *data-files-location* *fname*))
         (row (cl-csv:read-csv-row filepath)))
    (loop for key in row
          for i from 0
          collect (cons (name->keyword key) i))))

(defun row-value (key row)
  (let ((n (cdr (assoc key *headers*))))
    (nth n row)))

(defun nth-row-value (base n row)
  (let ((key (name->keyword (format nil "~a ~a" base n))))
    (row-value key row)))

(defun row->testcase (row)
  (make-testcase :id (row-value :cdc-test-id row)
                 :name (row-value :testcase-name row)
                 :description (row-value :general-description row)
                 :patient (row->patient row)
                 :vaccine-history (row->doses row)
                 :assessment-date (row-value :assessment-date row)
                 :series-status (row-value :series-status row)
                 :forecast-num (row-value :forecast-num row)
                 :earliest-date (row-value :earliest-date row)
                 :recommended-date (row-value :recommended-date row)
                 :past-due-date (row-value :past-due-date row)
                 :vaccine-group (row-value :vaccine-group row)
                 :evaluation-test-type (row-value :evaluation-test-type row)
                 :forecast-test-type (row-value :forecast-test-type row)
                 :date-added (row-value :date-added row)
                 :date-updated (row-value :date-updated row)
                 :reason-for-change (row-value :reason-for-change row)
                 :changed-in-version (row-value :changed-in-version row)))

(defun row->patient (row)
  (make-patient :dob (row-value :dob row)
                :gender (name->keyword (row-value :gender row))))

(defun row->doses (row)
  (remove-if #'(lambda (dose) (null (vaccine-dose-date dose)))
             (loop for n from 1 to 7
                   collect (make-vaccine-dose :date (nth-row-value "date administered" n row)
                                              :name  (nth-row-value "vaccine-name" n row)
                                              :cvx (nth-row-value "cvx" n row)
                                              :mvx (nth-row-value "mvx" n row)
                                              :evaluation-status (nth-row-value "evaluation status" n row)
                                              :evaluation-reason (nth-row-value "evaluation reason" n row)))))

(setf *headers* (read-headers))
(setf *testcases* (read-testcases))
