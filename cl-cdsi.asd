;;;; cl-cdsi.asd

(asdf:defsystem #:cl-cdsi
  :description "A vaccine evaluation engine based on the CDC CDSi Logic Spec."
  :author "Dennis Dunn <ansofive@gmail.com>"
  :license "MIT"
  :version "0.0.1"
  :depends-on (#:yason
               #:kebab
               #:drakma
               #:cl-ppcre
               #:local-time
               #:parse-float)
  :serial t
  :components ((:file "package")
               (:file "client")
               (:file "parse")
               (:file "plist")
               (:file "date")
	       (:file "conditional-skip")
               (:file "cdsi"))
  :in-order-to ((test-op (test-op "cl-cdsi/tests"))))

(asdf:defsystem #:cl-cdsi/tests
   :description "SDLC testing for the cl-cdsi system."
  :author "Dennis Dunn <ansofive@gmail.com>"
  :license "MIT"
  :version "0.0.1"
  :depends-on (#:cl-cdsi
	       #:fiveam)  
  :components ((:module "tests"
		:serial t
		:components ((:file "package")
			     (:file "main")
			     (:file "conditional-skip"))))
  :perform (test-op (o s)
		    (uiop:symbol-call :fiveam :run! 'cl-cdsi-tests:all-tests)))
