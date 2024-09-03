(in-package :support)

(defun list-schedules ()
  "Get the names of the tables as keywords."
  (let ((document (load-xml (merge-pathnames *schedule-name* *data-path*)))
        (keys 'nil))
    (xpath:do-node-set (node (xpath:evaluate "scheduleSupportingData/*" document))
      (push (xpath-protocol:local-name node) keys))
    (mapcar #'->keyword keys)))

(defun get-schedule (id)
  "Get the table identified by the keyword."
  (let ((document (load-xml (merge-pathnames *schedule-name* *data-path*)))
        (tag (kebab:to-camel-case id)))
    (xpath:evaluate (format nil "scheduleSupportingData/~a" tag) document)))

(defun get-antigen-by-cvx (cvx)
  (let* ((document (load-xml (merge-pathnames *schedule-name* *data-path*)))
         (nodes (xpath:evaluate (format nil "//cvxMap/cvx[text()='~a']/../association/antigen" cvx) document)))))
