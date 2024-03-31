(defsystem "cdsi"
           :version "0.1.0"
           :author "Dennis Dunn"
           :license "MIT"
           :depends-on ("cl-ppcre"
                        "kebab"
                        "cxml"
                        "xpath")
           :serial t
           :components ((:module "src"
                                 :components
                                 ((:module "calendar"
                                           :components
                                           ((:file "packages")
                                            (:file "calendar")))
                                  (:module "support"
                                           :components
                                           ((:file "packages")
                                            (:file "common")
                                            (:file "antigen")
                                            (:file "schedule")))
                                  (:file "packages"))))
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
