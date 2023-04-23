(in-package :cl-cdsi/supporting-data)

(defstruct vaccine
  cvx
  description
  associations)

(defstruct association
  antigen
  begin-age
  end-age)

(defun get-vaccine-nodes ()
  (xmls:xmlrep-find-child-tags "cvxMap" (xmls:xmlrep-find-child-tag "cvxToAntigenMap" (cdsi-support:schedule))))

(defun as-vaccine (node)
  (make-vaccine :cvx (get-integer-value node "cvx")
                :description (get-string-value node "shortDescription")
                :associations (mapcar #'as-association (xmls:xmlrep-find-child-tags "association" node))))

(defun as-association (node)
  (make-association :antigen (get-string-value node "antigen")
                    :begin-age (get-age-value node "associationBeginAge")
                    :end-age (get-age-value node "associationEndAge")))

(defun get-vaccine-node (cvx)
  (find-if (lambda (node)
             (= cvx (get-integer-value node "cvx")))
      (get-vaccine-nodes)))

(defgeneric get-vaccine (cvx)
  (:documentation "Get the vaccine from the supporting data."))

(defmethod get-vaccine ((cvx integer))
  (as-vaccine (get-vaccine-node cvx)))

(defmethod get-vaccine ((cvx string))
  (get-vaccine (parse-integer cvx)))