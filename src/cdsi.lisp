(in-package :cl-user)

(defpackage :cdsi
  (:use :cl
        :cdsi/core
        :cdsi/core/calendar
        :cdsi/core/health-records
        :cdsi/core/supporting-data
        :cdsi/processing-model/gather-information))

(in-package :cdsi)

