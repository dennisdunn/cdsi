(in-package :support)

(defun load-cases ()
    (with-open-file (stream (merge-pathnames *cases-name* *data-path*))
                      (json:with-decoder-simple-list-semantics
                          (json:decode-json-from-source  stream))))

(defun list-cases ()
   (mapcar #'(lambda (lst) (cdr (assoc :key lst))) (load-cases)))

(defun get-case (key)
    (car (remove-if-not #'(lambda (lst) (equal (cdr (car lst)) key)) (load-cases))))