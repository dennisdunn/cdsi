;;;; date-calc.lisp

(in-package :cl-cdsi)

(defclass date ()
  ((year :initform 1900)
   (month :initform 1)
   (day :initform 1)))

(defclass interval ()
  ((unit :initform :day)
   (value :initform 0)))
