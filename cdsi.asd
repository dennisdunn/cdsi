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
                        ((:file "common")
                         (:file "property-bag")
                         (:file "calendar" :depends-on ("common"))
                         (:file "supporting-data" :depends-on ("common"))
                         (:file "gather-info" :depends-on ("supporting-data"))
                         (:file "cdsi"))))
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
