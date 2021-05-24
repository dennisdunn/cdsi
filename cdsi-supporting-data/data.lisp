
(in-package :cdsi-supporting-data)

(defparameter *data-files-location* #P"/home/owner/source/cdsi/cl-cdsi/data-files/supporting-data/4.10/")

(defparameter *schedule-fname* #P"ScheduleSupportingData.xml")

(defparameter *antigen-file-re* "AntigenSupportingData- (.*)-508.xml")

(defun antigen-names ()
  "Return a list of antigen names."
  (remove-if #'null 
             (mapcar (lambda (fname)
                       (register-groups-bind (antigen) 
                                             (*antigen-file-re* (namestring fname))
                                             antigen))
                     (uiop:directory-files *data-files-location*))))

(defun get-antigen (name)
  "Load and parse the antigen file identified by the name."
 (let* ((fname (regex-replace "[(.*)]+" *antigen-file-re* name))
        (path (merge-pathnames *data-files-location* fname)))
   (parse (uiop:read-file-string path))))

(defun get-schedule ()
  "Get the schedule supporting data."
  (parse (uiop:read-file-string (merge-pathnames *data-files-location* *schedule-fname*))))

(defun vaccine-list ()
  "Get a list of available vaccines.")


