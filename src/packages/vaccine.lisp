(in-package :cl-user)

(defpackage :cdsi.vaccine
  (:use :cl
        :cdsi.util
        :cdsi.calendar)
  (:export :get-vaccine
           :vaccine
           :vaccine-cvx
           :vaccine-description
           :vaccine-associations
           :vaccine-antigens
           :association
           :association-antigen
           :association-begin-age
           :association-end-age))

(in-package :cdsi.vaccine)

;;;; Schedule data

(defstruct vaccine
  cvx
  description
  associations)

(defstruct association
  antigen
  begin-age
  end-age)

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
      (cdsi.data:get-schedule "cvxToAntigenMap")))

(defgeneric get-vaccine (cvx)
  (:documentation "Get the vaccine from the supporting data."))

(defmethod get-vaccine ((cvx integer))
  (as-vaccine (get-vaccine-node cvx)))

(defmethod get-vaccine ((cvx string))
  (get-vaccine (parse-integer cvx)))

(defgeneric vaccine-antigens (cvx)
  (:documentation "Get the associated antigens for the vaccine."))

(defmethod vaccine-antigens ((cvx vaccine))
  (mapcar #'association-antigen (vaccine-associations cvx)))

(defmethod vaccine-antigens ((cvx integer))
  (vaccine-antigens (get-vaccine cvx)))
