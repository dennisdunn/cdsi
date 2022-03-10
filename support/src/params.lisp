(in-package :cl-cdsi/support)


(defparameter *schedule-data-location* #P"/home/dennisd/source/cdsi/cl-cdsi/data-files/supporting-data/4.10/")
(defparameter *testcase-data-location* #P"/home/dennisd/source/cdsi/cl-cdsi/data-files/testcases/")

(defparameter *schedule-file-name* #P"ScheduleSupportingData.xml")
(defparameter *testcase-file-name* #P"cdsi-healthy-childhood-and-adult-test-cases-v4.8.csv")

(defparameter *antigen-file-re* "AntigenSupportingData- (.*)-508.xml")


(defparameter *headers* nil)
(defparameter *testcases* nil)

