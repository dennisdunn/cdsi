(in-package :cl-cdsi/support)

(defun testcase (id)
  "Fetch a testcase by id."
  (let* ((testcase (read-testcase id))
         (test-info (get-test-info testcase))
         (node (alist->node "testcase" test-info))
         (doses (loop for i from 1 to 7
                      collect (dose-info->node i (get-dose-info i testcase)))))
    (setf (node-children node) (append (node-children node) (remove-empty-doses doses)))
    node))

(defun testcase-ids ()
  "Get a list of the testcase ids."
  (let ((path (merge-pathnames *testcase-data-location* *testcase-file-name*)))
    (cdr (csv-column path 0))))

(defun read-testcase (id)
  "Read the testcase as an alist."
  (let* ((path (merge-pathnames *testcase-data-location* *testcase-file-name*))
         (row (csv-find path id))
         (headers (csv-headers path)))
    (kvp->alist headers row)))

(defun get-test-info (alist)
  "Get the non-dose realated information from the testcase."
  (remove-if #'(lambda (item) (ppcre:scan "\\d$" (car item))) alist))

(defun get-dose-info (idx alist)
  "Get the dose information from the alist"
  (remove-if-not #'(lambda (item) (ppcre:scan (format nil "~A$" idx) (car item))) alist))

(defun remove-indexes (alist)
  "Remove the numerical suffix from each key in the alist"
  (mapcar #'(lambda (item) (setf (car item) (ppcre:regex-replace "\\d$" (car item) "")) item) alist))

(defun dose-info->node (idx alist)
  "Get the referenced dose from the source, remove indexes, and create a node."
  (alist->node "dose" (cons `("doseNumber" . ,idx) (remove-indexes alist))))

(defun remove-empty-doses (doses)
  "Remove dose nodes that are empty."
  (remove-if #'(lambda (dose) (null (node-children (second (node-children dose))))) doses))

