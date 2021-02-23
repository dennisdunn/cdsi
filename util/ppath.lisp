;;;; ppath.lisp


;; get the unit of the *conditions* first begin-age interval.
;; (ppath *condition* (:begin-age 0 :unit))
;; (GETF (NTH 0 (GETF *CONDITION* :BEGIN-AGE)) :UNIT)


(defmacro getk (list key)
  (cond ((symbolp key) `(getf ,list ,key))
	((numberp key) `(nth ,key ,list))))

(defmacro ppath (list keys)
  (let ((key (first keys))
	(rest (rest keys)))
    (if (null keys)
	list
	`(ppath (getk ,list ,key) ,rest))))
