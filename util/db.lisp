;;;; db.lisp

(defgeneric select (key &key from)
  (:documentation "Select fields from the target."))

(defmethod select ((key symbol) &key from)
  (if (eq key :*)
      from
      (getf from key)))

(defmethod select ((key number) &key from)
  (nth key from))

(defmethod select ((key string) &key from)
  (let ((symbol-key (intern (string-upcase key) "KEYWORD")))
    (select symbol-key :from from)))
