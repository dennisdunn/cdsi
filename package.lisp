;;;; package.lisp


(defpackage #:cl-cdsi-date
  (:nicknames #:cdsi-dt)
  (:use #:cl
        #:cl-ppcre)
  (:export :parse-interval
	   :parse-date))

(defpackage #:cl-cdsi
  (:nicknames #:cdsi)
  (:use #:cl-cdsi-date
	#:cl
        #:cl-ppcre
        #:parse-float))
