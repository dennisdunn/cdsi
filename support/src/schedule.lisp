(in-package :support)

;; Schedule

(defun schedule ()
  "Get the schedule supporting data."
  (xmls:parse (uiop:read-file-string (merge-pathnames *data-path* *schedule-file-name*))))

(defun cvx-antigen-map (schedule)
  "Get the cvx-to-antigen-map from the schedule data."
  (car (xmls:xmlrep-find-child-tags "cvxToAntigenMap" schedule)))

(defun get-cvx (cvx-antigen-map cvx)
  "Get the cvx from the antigen map."
  (car (loop for cvxmap in (xmls:xmlrep-find-child-tags "cvxMap" cvx-antigen-map)
             when (eq cvx (parse-integer (car (xmls:xmlrep-children (car (xmls:xmlrep-find-child-tags "cvx" cvxmap))))))
             collect cvxmap)))

(defun get-antigens (cvx)
  "Get the antigens associated with the cvx."
  (loop for association in (xmls:xmlrep-find-child-tags "association" cvx)
        collect (read-from-string (car (xmls:xmlrep-children association)))))