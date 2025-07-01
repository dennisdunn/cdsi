(in-package :cl-user)

(defpackage :cdsi/tests/gather-information
  (:use :cl
        :fiveam
        :cdsi/core
        :cdsi/core/calendar))

(in-package :cdsi/tests/gather-information)

(def-suite* gather-info :in cdsi/tests::cdsi) ; how do you export a suite from a package?
