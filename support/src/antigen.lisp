(in-package :support)

(defun antigen (id)
  "Load and parse the antigen file identified by the name."
  (let* ((fname (ppcre:regex-replace "[(.*)]+" *antigen-file-re* id))
         (path (merge-pathnames *data-path* fname)))
    (cxml:parse-file path (cxml-dom:make-dom-builder))))

(defun antigen-ids ()
  "Return a list of antigen names."
  (remove-if #'null
             (mapcar (lambda (fname)
                       (ppcre:register-groups-bind (antigen)
                                                   (*antigen-file-re* (namestring fname))
                                                   antigen))
                     (uiop:directory-files *data-path*))))
