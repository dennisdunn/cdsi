;;;; Conditional Skip
;;;; Determines if a target dose can be skipped.

(in-package :cl-cdsi)

(defmacro with-logic (logic args)
  (case logic
    ((:and) `(and ,@args))
    ((:or) `(or ,@args))
    ((:greater-than) `(> ,@args))
    ((:less-than) `(< ,@args))
    ((:equal) `(equal ,@args))	 
    ((t nil))))

(defun get-skip-condition-sets (dose context)
  "Returns the relevant skip conditions from the target dose for the specified context. eg: :evaluation or :forecast"
  (flet ((not-skip-p (condition)
	   (let ((ctx (getf condition :context)))
	     (or (eq ctx context)
		 (eq ctx :both)))))
	 (remove-if-not #'not-skip-p (getf dose :conditional-skip))))


(defmacro make-condition-evaluator (condition)
  (case (getf condition :condition-type)
    ((:age) (condition-a condition))
    ((:interval) (condtion-i condition))
    ((:completed-series) (condition-cs condition))
    ((:vaccine-count-by-age) (condition-vcba condition))
    ((:vaccine-count-by-date) (condition-vcbd condition))
    (t (error "unknown conditional skip condition type"))))

(defmacro condition-a (condition)
  `(lambda (medical)
     (let* ((dob (getf medical :dob))
	    (begin (date:apply-intervals dob (getf ,condition :begin-age)))
	    (end (date:apply-intervals dob (getf ,condition :end-age) date:*max-date*)))
       (local-time:timestamp<= begin  (getf medical :assessment-date) end))))

(defun select (key place)
  (cond ((symbolp key) (getf place key))
	((numberp key) (nth key place))
	(t (error "unknown-key-type"))))
