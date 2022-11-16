(in-package :schedule)

(defun get-data ()
  "Get the schedule supporting data."
  (xmls:parse (uiop:read-file-string (merge-pathnames *data-path* *schedule-file-name*))))
