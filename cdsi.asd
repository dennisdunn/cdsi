(in-package :asdf-user) ; important!

(defsystem "cdsi"
  :version "0.1.0"
  :author "Dennis Dunn"
  :license "MIT"
  :depends-on ("cl-ppcre"
               "cl-json"
               "dexador"
               "kebab")
  :serial t
  :components ((:module "src"
                        :components
                        ((:module "core"
                                  :components
                                  ((:file "core")
                                   (:file "calendar")
                                   (:file "health-records")
                                   (:file "supporting-data")))
                         (:module "processing-model"
                                  :components
                                  ((:file "gather-information")))
                         (:file "cdsi"))))
  :description "A vaccine evaluation engine based on the CDC CDSi Logic Spec."
  :in-order-to ((test-op (test-op "cdsi/tests"))))

(defsystem "cdsi/tests"
  :author "Dennis Dunn"
  :license "MIT"
  :depends-on ("cdsi"
               "fiveam")
  :serial t
  :components ((:module "tests"
                        :components
                        ((:file "main")
                         (:file "calendar")
                         (:file "health-records"))))
  :description "Test system for cl-cdsi"
  :perform (test-op (op c) (symbol-call :fiveam :run! (find-symbol* :cdsi :cdsi/tests))))
