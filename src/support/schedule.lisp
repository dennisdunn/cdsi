(in-package :support)

(defun list-schedules ()
  "Get the names of the tables as keywords."
  (let ((document (load-xml (merge-pathnames *data-path* *schedule-name*)))
        (keys 'nil))
    (xpath:do-node-set (node (xpath:evaluate "scheduleSupportingData/*" document))
      (push (xpath-protocol:local-name node) keys))
    (mapcar #'->keyword keys)))

(defun get-schedule (id)
  "Get the table identified by the keyword."
  (let ((document (load-xml (merge-pathnames *data-path* *schedule-name*)))
        (tag (kebab:to-camel-case id)))
    (xpath:evaluate (format nil "scheduleSupportingData/~a" tag) document)))
