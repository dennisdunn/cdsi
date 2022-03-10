(in-package :caselib)

(defparameter *data-path* "../data")
(defparameter *file-name* "cdsi-healthy-childhood-and-adult-test-cases-v4.8.csv")

(defun catalog ()
  "Get a catalog of all testcases."
  (let ((path (merge-pathnames *data-path* *file-name*)))
    (multiple-value-bind (header data) (csv-read path)
      (mapcar #'(lambda (row)
                  (make-testcase :id (csv-value header row "CDC_Test_ID")
                                 :name (csv-value header row "Test_Case_Name")
                                 :text (csv-value header row "General_Description"))) 
              data))))

(defun catalog-read (id)
  "Load the testcase identified by the argument.")
