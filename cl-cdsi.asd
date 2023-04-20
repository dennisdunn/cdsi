(defsystem "cl-cdsi"
           :version "0.1.0"
           :author "Dennis Dunn"
           :license "MIT"
           :depends-on (:cl-ppcre)
           :components ((:module "src"
                                 :components
                                 ((:file "packages")
                                  (:file "date-math")
                                  (:file "main"))))
           :description "A vaccine evaluation engine based on the CDC CDSi Logic Spec."
           :in-order-to ((test-op (test-op "cl-cdsi/tests"))))


(defsystem "cl-cdsi/tests"
           :author "Dennis Dunn"
           :license "MIT"
           :depends-on (:cl-cdsi
                        :fiveam)
           :components ((:module "tests"
                                 :components
                                 ((:file "packages")
                                  (:file "main")
                                  (:file "date-math"))))
           :description "Test system for cl-cdsi"
)
     ;      :perform (test-op (o c) (symbol-call :fiveam :run! 'cl-cdsi/tests:all-tests)))
