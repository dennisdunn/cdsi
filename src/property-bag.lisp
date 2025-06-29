(in-package :cl-user)

(defpackage :cdsi.property-bag
  (:use :cl)
    (:nicknames :pbag)
  (:export ))

(in-package :cdsi.property-bag)


(defclass property-bag () ((data
                            :initarg :data
                            :initform nil
                            :accessor bag-data)))

(defgeneric get-value (bag key)
    (:documentation "Get the named value from the property-bag."))

(defmethod get-value ((bag property-bag) key)
    (cdr (assoc key (bag-data bag))))

(defgeneric set-value (bag key value)
    (:documentation "Set the named value of the property-bag to the parameter."))

(defmethod set-value ((bag property-bag) key value)
    (push (cons key value) (bag-data bag)))
