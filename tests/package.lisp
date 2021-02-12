;;;; package.lisp

(defpackage #:cl-cdsi-tests
  (:nicknames #:tests)
  (:use #:cl
	#:cl-cdsi
	#:fiveam)
  (:export #:run!
	   #:all-tests))
