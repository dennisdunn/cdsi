;;;; cdsi/package.lisp

(defpackage :cl-cdsi
  (:nicknames :cdsi)
  (:use :cl
        :cl-cdsi/util
        :cl-cdsi/support)
  (:export :series-standard-p
           :series-required-gender-p))

