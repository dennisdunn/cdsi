(in-package :cl-cdsi/support)

  
(defun testcase (key)
  "Get the testcase identified by the key.")

(defun testcase-keys ()
  "Get a list of the testcase ids."
   (let ((path (merge-pathnames *testcase-data-location* *testcase-file-name*)))
    (mapcar #'name->keyword (cdr (csv-column path 0)))))

(defun testcase->alist (key)
  "Fetch a testcase by id."
 (let* ((path (merge-pathnames *testcase-data-location* *testcase-file-name*))
        (row (csv-find path key))
        (headers (csv-headers path)))
   (kvp->alist headers row)))


