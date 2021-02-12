;;;; package.lisp

(defpackage #:cl-cdsi-tests
  (:nicknames #:tests)
  (:use #:cl
	#:fiveam)
  (:export #:run!
	   #:all-tests
	   #:test-cdsi))
