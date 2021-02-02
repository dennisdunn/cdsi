;;;; package.lisp

(defpackage #:cl-cdsi-client
  (:nicknames #:client)
  (:use #:cl
        #:cl-ppcre
        #:parse-float)
  (:export :fetch
	   :*base-url*))

(defpackage #:cl-cdsi-date
  (:nicknames #:datecalc)
  (:use #:cl
        #:cl-ppcre
	#:local-time)
  (:export :parse-interval
	   :date+))

(defpackage #:cl-cdsi
  (:nicknames #:cdsi)
  (:use	#:cl
	#:cl-cdsi-date
	#:cl-cdsi-client))
