(in-package :caselib)

(defparameter *data-path* "./caselib/data/")
(defparameter *file-name* "cdsi-healthy-childhood-and-adult-test-cases-v4.8.csv")

(defun catalog ()
  "Get a catalog of all testcases."
  (let* ((path (merge-pathnames *data-path* *file-name*)))
    (multiple-value-bind (header items) (csv-read path)
      (mapcar #'(lambda (row)
                  (make-testcase :id (csv-value header row "CDC_Test_ID")
                                 :name (csv-value header row "TestCase_Name")
                                 :text (csv-value header row "General_Description"))) 
              items))))

(defun catalog-read (id)
  "Load the testcase identified by the argument."
  id)
