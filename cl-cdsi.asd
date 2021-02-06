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
               (:file "cdsi")))
