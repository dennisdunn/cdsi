;;;; Networking

(in-package #:cl-cdsi-client)

(defparameter *base-url* "https://cdsi-api.herokuapp.com/api")

(defun fetch (&rest fragments)
  (let* ((path (format nil "~{~A~^/~}" (push *base-url* fragments)))
         (url (cl-ppcre:regex-replace-all " " path "%20"))
         (yason:*parse-object-key-fn* #'parse:as-keyword)
         (stream (drakma:http-request url :want-stream t)))
    (setf (flexi-streams:flexi-stream-external-format stream) :utf-8)
    (convert-all (yason:parse stream :object-as :plist))))

(defparameter *date-keys* '(:DATE-ADMINISTERED
			    :LOT-EXPIRATION
			    :DOB
			    :ASSESSMENT-DATE
			    :EARLIEST-DATE
			    :PAST-DUE-DATE
			    :RECOMMENDED-DATE
			    :DATE-ADDED
			    :DATE-UPDATED))

(defparameter *keyword-keys* '(:MVX
			       :ANTIGEN
			       :GENDER
			       :DOSE-NUMBER
			       :EVALUATION-STATUS
			       :SERIES-STATUS
			       :VACCINE-GROUP
			       :TARGET-DISEASE
			       :SERIES-TYPE
			       :SERIES-PRIORITY
			       :SERIES-GROUP-NAME))

(defparameter *number-keys* '(:CVX
			      :GUIDELINE-CODE
			      :CODE
			      :SERIES-GROUP
			      :FORECAST-NUM
			      :FROM-TARGET-DOSE
			      :SERIES-TYPE
			      :SERIES-PREFERENCE
			      :EQUIVALENT-SERIES-GROUPS
			      :OBSERVATION-CODE
			      :VOLUME
			      :CHANGED-IN-VERSION))

(defparameter *boolean-keys* '(:RECURRING-DOSE
			       :FORECAST-VACCINE-TYPE
			       :FROM-PREVIOUS
			       :DEFAULT-SERIES
			       :PRODUCT-PATH))

(defparameter *interval-keys* '(:ABS-MIN-AGE
				:MIN-AGE
				:EARLIEST-REC-AGE
				:LATEST-REC-AGE
				:MAX-AGE			
				:EFFECTIVE-DATE
				:CESSATION-DATE
				:BEGIN-AGE
				:END-AGE
				:ABS-MIN-INT
				:MIN-INT
				:EARLIEST-REC-INT
				:LATEST-REC-INT
				:MIN-AGE-TO-START
				:MAX-AGE-TO-START))


(defun with-plist-key (fn key)
  "Create a function that will apply the function (fn) to the value returned by (getf plist key)"
  (lambda (plist)
    (let ((value (getf plist key)))
      (when value
	(setf (getf plist key) (funcall fn value))))))

(defun convert-values (fn keys thing)
  "Apply the function (fn) to each of the values retrieved by (getf key thing)"
  (let ((fns (mapcar (lambda (key) (with-plist-key fn key)) keys)))
    (mapc (lambda (fn) (visit fn thing)) fns))
  thing)

(defun convert-all (thing)
  (convert-values #'parse:as-date *date-keys* thing)
  (convert-values #'parse:as-keyword *keyword-keys* thing)
  (convert-values #'parse:as-number *number-keys* thing)
  (convert-values #'parse:as-interval *interval-keys* thing)
  (convert-values #'parse:as-boolean *boolean-keys* thing))
