(in-package :cdsi-testcases)

(defparameter *data-files-location* #P"/home/owner/source/cdsi/cl-cdsi/data-files/testcases/")
(defparameter *fname* #P"cdsi-healthy-childhood-and-adult-test-cases-v4.8.csv")

(defun get-data ()
  (let* ((data (read-csv (merge-pathnames *data-files-location* *fname* ) 
                         :unquoted-empty-string-is-nil t
                         :trim-outer-whitespace t))
         (headers (car data))
         (rows (cdr data)))
    (setf headers (mapcar (lambda (header)
                            (read-from-string (to-kebab-case header)))
                          headers))
    (mapcar (lambda (row)
                    (loop for key in headers
                          for value in row
                          collect (cons key value)))
            rows)))
