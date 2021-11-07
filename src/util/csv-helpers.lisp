(in-package :cl-cdsi/util)

(defun csv-read (path)
  "Read the csv file and return the list of rows."
  (cl-csv:read-csv path :unquoted-empty-string-is-nil t
                   :trim-outer-whitespace t))

(defun csv-headers (path)
  "Read the first line of the testcase file and return an alist mapping column name to column number."
  (loop for key in (cl-csv:read-csv-row path)
        for i from 0
        collect (cons (name->keyword key) i)))

(defun csv-column (path n)
  "Get the nth column of the csv file."
  (cl-csv:read-csv path :unquoted-empty-string-is-nil t
                   :trim-outer-whitespace t
                   :map-fn #'(lambda (row) (nth n row))))

(defun csv-row (path n)
  "Get the nth row of the csv file."
  (nth n (csv-read path)))

(defun csv-find (path key)
  "Find the first row whose first column equals the key."
  (find-if (lambda (row)
             (eq key (name->keyword (car row))))
           (csv-read path)))
