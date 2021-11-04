(in-package :cl-cdsi/util)

(defun tag-attach (tag datum)
  "Tag some data."
  (cons tag datum))

(defun tag-type (datum)
  "Fetch the type of the tagged data."
  (if (tag-p datum)
    (car datum)
    (error "Bad tagged data - TAG-TYPE" datum)))

(defun tag-content (datum)
  "Return the content of the tagged data."
  (if (tag-p datum)
    (cdr datum)
    (error "Bad tagged data - TAG-CONTENT" datum)))

(defun tag-p (datum)
  "Return T iff the argument is a tagged datatype."
  (and (consp datum) 
       (keywordp (car datum))
       (not (keywordp (cadr datum)))))

