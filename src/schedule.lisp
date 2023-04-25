(in-package :cdsi.schedule)

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

(defgeneric get-vaccine-antigens (cvx)
            (:documentation "Get the associated antigens for the vaccine."))

(defmethod get-vaccine-antigens ((cvx vaccine))
           (mapcar #'association-antigen (vaccine-associations cvx)))

(defmethod get-vaccine-antigens ((cvx integer))
           (get-vaccine-antigens (get-vaccine cvx)))

;;;; Xml helpers

(defun get-value (parser node tag)
  (funcall parser (xmls:xmlrep-string-child (xmls:xmlrep-find-child-tag tag node) nil)))

(defun get-string-value (node tag)
  (get-value #'identity node tag))

(defun get-integer-value (node tag)
  (get-value #'parse-integer node tag))

(defun get-date-value (node tag)
  (get-value #'parse-date node tag))

(defun get-age-value (node tag)
  (get-value #'parse-interval node tag))

(defun get-bool-value (node tag)
  (get-value #'parse-bool node tag))
