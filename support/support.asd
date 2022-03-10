;;;; cl-cdsi.asd

(defsystem :support
  :description "CDSi supporting data package."
  :author "Dennis Dunn <ansofive@gmail.com>"
  :license "MIT"
  :version "0.1.0"
  :serial t
  :depends-on ()
  :components ((:module "src"
                        :serial t
                        :components ((:file "package")))))

(defsystem :support/tests
  :author "Dennis Dunn <ansofive@gmail.com>"
  :license "MIT"
  :version "0.1.0"
  :depends-on (:cl-cdsi
               :fiveam)
  :components ((:module "t"
                        :serial t
                        :components ((:file "package")
                                     (:file "main")
                                     (:file "support"))))
