(defsystem "cdsi"
           :version "0.1.0"
           :author "Dennis Dunn"
           :license "MIT"
           :depends-on ("cl-ppcre"
                        "kebab"
                        "drakma"
                        "yason")
           :serial t
           :components ((:module "src"
                                 :components

                                 ((:file "packages")
                                  (:module "lib"
                                           :components
                                           ((:file "calendar")
                                            (:file "api")
                                            (:file "parsers"))))))
           :description "A vaccine evaluation engine based on the CDC CDSi Logic Spec."
           :in-order-to ((test-op (test-op "cdsi/tests"))))


(defsystem "cdsi/tests"
           :author "Dennis Dunn"
           :license "MIT"
           :depends-on ("cdsi"
                        "rove")
           :components ((:module "tests"
                                 :components
                                 ((:file "packages")
                                  (:file "calendar")
                                  (:file "patient"))))
           :description "Test system for cl-cdsi"
           :perform (test-op (op c) (symbol-call :rove :run c)))
