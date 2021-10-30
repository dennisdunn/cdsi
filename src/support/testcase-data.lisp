(in-package :cl-cdsi/support)

(defparameter *data-files-location* #P"/home/dennisd/source/cdsi/cl-cdsi/data-files/testcases/")
(defparameter *fname* #P"cdsi-healthy-childhood-and-adult-test-cases-v4.8.csv")
(defparameter *headers* nil)
(defparameter *testcases* nil)

(defun testcase (id)
  "Return the testcase identified by the string id."
  (find-if #'(lambda (x) (equal id (testcase-id x))) *testcases*))

(defun testcase-assessment (id)
  "Return testcase data as assessment information."
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
  "Read the first line of the testcase file and return an alist mapping column name to column number."
  (let* ((filepath (merge-pathnames *data-files-location* *fname*))
         (row (cl-csv:read-csv-row filepath)))
    (loop for key in row
          for i from 0
          collect (cons (u:name->keyword key) i))))

(defun row-value (key row)
  "Get the value identified by the column name."
  (let ((n (cdr (assoc key *headers*))))
    (nth n row)))

(defun nth-row-value (base n row)
  "Get the value identified by the column named 'base-n' eg: 'date-administered-1'"
  (let ((key (name->keyword (format nil "~a ~a" base n))))
    (row-value key row)))

(defun row->testcase (row)
  "Create a testcase struct from the given row."
  (make-testcase :id (row-value :cdc-test-id row)
                 :name (row-value :testcase-name row)
                 :description (row-value :general-description row)
                 :patient (row->patient row)
                 :vaccine-history (row->doses row)
                 :assessment-date (row-value :assessment-date row)
                 :series-status (u:name->keyword (row-value :series-status row))
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
  "Create a patient structure from the row."
  (make-patient :dob (row-value :dob row)
                :gender (u:name->keyword (row-value :gender row))))

(defun row->doses (row)
  "Create a list of administered vaccine doses from the row."
  (remove-if #'(lambda (dose) (null (vaccine-dose-date dose)))
             (loop for n from 1 to 7
                   collect (make-vaccine-dose :date (nth-row-value "date administered" n row)
                                              :name (nth-row-value "vaccine-name" n row)
                                              :cvx (nth-row-value "cvx" n row)
                                              :mvx (nth-row-value "mvx" n row)
                                              :evaluation-status (nth-row-value "evaluation status" n row)
                                              :evaluation-reason (nth-row-value "evaluation reason" n row)))))

(setf *headers* (read-headers))
(setf *testcases* (read-testcases))
