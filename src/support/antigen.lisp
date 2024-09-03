(in-package :support)

(defun list-antigens ()
  "Get a list of all of the antigen ids."
  (mapcar #'get-antigen-id (list-antigen-files)))

(defun get-antigen (id)
  "Read the antigen file identified by the keyword."
  (load-xml (car (remove-if-not (lambda (path)
                                      (eq id (get-antigen-id path)))
                         (list-antigen-files)))))

(defun list-antigen-files ()
  "Get a list of all of the antigen files in the *data-path*."
  (let ((*default-pathname-defaults* (pathname *data-path*)))
    (directory *antigen-name-glob*)))

(defun get-antigen-name (path)
  "Return the antigens name."
  (cl-ppcre:register-groups-bind (key) (*antigen-name-re* (pathname-name path))
    key))

(defun get-antigen-id (path)
  "Return the name of the antigen as a keyword."
  (->keyword (get-antigen-name path)))
