(in-package :support)

;; Schedule

(defun schedule ()
  "Get the schedule supporting data."
  (cxml:parse-file (merge-pathnames *data-path* *schedule-file-name*) (cxml-dom:make-dom-builder)))

(defun get-cvx (cvx)
  "Get the cvx from the antigen map."
  (xpath:evaluate (format nil "//cvxMap[cvx=~A]//antigen" cvx) *schedule*))

(defun get-antigens (cvx)
  "Get the antigens associated with the cvx."
  (xpath:map-node-set->list #'xpath:string-value (get-cvx cvx)))

(defparameter *schedule* (schedule))
