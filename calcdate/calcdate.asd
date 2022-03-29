;;;; cl-cdsi.asd

(defsystem :calcdate
  :description "Date calculations based on the CDC CDSi Logic Spec."
  :author "Dennis Dunn <ansofive@gmail.com>"
  :license "MIT"
  :version "0.1.0"
  :serial t
  :depends-on (:cl-ppcre
               :local-time
               :kebab)

  :components ((:module "src"
                        :serial t
                        :components ((:file "package")
                                     (:file "calcdate"))))
  :in-order-to ((test-op (test-op :calcdate/tests))))

(defsystem :calcdate/tests
  :author "Dennis Dunn <ansofive@gmail.com>"
  :license "MIT"
  :version "0.1.0"
  :depends-on (:calcdate
               :fiveam)
  :components ((:module "t"
                        :serial t
                        :components ((:file "package")
                                     (:file "main")
                                     (:file "calcdate"))))
  :perform (test-op (op c) (symbol-call :fiveam :run!
                                        (find-symbol* 'all-tests :calcdate/tests))))
