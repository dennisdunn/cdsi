(in-package :cl-cdsi/support)

(defun antigen-names ()
  "Return a list of antigen names."
  (remove-if #'null 
             (mapcar (lambda (fname)
                       (ppcre:register-groups-bind (antigen)
                                                   (*antigen-file-re* (namestring fname))
                                                   antigen))
                     (uiop:directory-files *schedule-data-location*))))

(defun read-antigen (name)
  "Load and parse the antigen file identified by the name."
  (let* ((fname (ppcre:regex-replace "[(.*)]+" *antigen-file-re* name))
         (path (merge-pathnames *schedule-data-location* fname)))
    (xmls:parse (uiop:read-file-string path))))

(defun antigen (key)
  "Get the xml associated with this keyword symbol."
  (let ((name (getf (symbol-plist key) :name)))
    (read-antigen name)))

(defun antigen-keys ()
  "Get the antigen names as keyword symbols."
  (mapcar #'name->keyword (antigen-names)))

;;;; Initialize the package
(antigen-keys)
