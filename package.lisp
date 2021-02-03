;;;; package.lisp

(defpackage #:cl-cdsi-client
  (:nicknames #:client)
  (:use #:cl
        #:cl-ppcre
        #:parse-float)
  (:export :fetch
	   :*base-url*))

(defpackage #:cl-cdsi-date
  (:nicknames #:calcdate)
  (:use #:cl
        #:cl-ppcre
	#:local-time)
  (:export :parse-intervals
	   :apply-intervals
	   :date+))

(defpackage #:cl-cdsi
  (:nicknames #:cdsi)
  (:use	#:cl
	#:cl-cdsi-date
	#:cl-cdsi-client))
