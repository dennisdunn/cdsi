(in-package :cl-cdsi/support)

;; Schedule

(defun schedule ()
  "Get the schedule supporting data."
  (xmls:parse (uiop:read-file-string (merge-pathnames *schedule-data-location* *schedule-file-name*))))
