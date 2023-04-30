(in-package :cdsi.vaccine)

(defun get-vaccine-node (cvx)
  (find-if (lambda (node)
             (= cvx (get-integer-value node "cvx")))
      (cdsi.data:get-schedule "cvxToAntigenMap")))

(defgeneric vaccine (cvx)
  (:documentation "Get the vaccine from the supporting data."))

(defmethod vaccine ((cvx integer))
  (get-vaccine-node cvx))

(defmethod vaccine ((cvx string))
  (parse-integer cvx))

(defun vaccine-cvx (treenode)
  (get-integer-value treenode "cvx"))

(defun vaccine-description (treenode)
  (get-string-value treenode "description"))

(defun vaccine-associations (treenode)
  (xmls:xmlrep-find-child-tags "association" treenode))

(defun vaccine-antigens (treenode)
  (mapcar #'association-antigen (vaccine-associations treenode)))

(defun association-antigen (treenode)
  (get-string-value treenode "antigen"))

(defun association-begin-age (treenode)
  (get-date-value treenode "beginAge"))

(defun association-end-age (treenode)
  (get-date-value treenode "endAge"))
