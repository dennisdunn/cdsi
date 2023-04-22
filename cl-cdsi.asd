(defsystem "cl-cdsi"
           :version "0.1.0"
           :author "Dennis Dunn"
           :license "MIT"
           :depends-on ("cl-ppcre"
                        "cl-cdsi-cases"
                        "cl-cdsi-support")
           :components ((:module "src"
                                 :components
                                 ((:file "packages")
                                  (:file "calendar")
                                  (:file "ehr-interface")
                                  (:file "supporting-data")
                                  (:file "main"))))
           :description "A vaccine evaluation engine based on the CDC CDSi Logic Spec."
           :in-order-to ((test-op (test-op "cl-cdsi/tests"))))


(defsystem "cl-cdsi/tests"
           :author "Dennis Dunn"
           :license "MIT"
           :depends-on ("cl-cdsi"
                        "rove")
           :components ((:module "tests"
                                 :components
                                 ((:file "packages")
                                  (:file "calendar")
                                  (:file "ehr-interface")
                                  (:file "supporting-data"))))
           :description "Test system for cl-cdsi"
           :perform (test-op (op c) (symbol-call :rove :run c)))
