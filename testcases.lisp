(in-package :testcases)

(defparameter *data-files-location* #P"/home/owner/source/cdsi/cl-cdsi/data-files/testcases/")
(defparameter *fname* #P"cdsi-healthy-childhood-and-adult-test-cases-v4.8.csv")

(defun to-symbol (&rest parts)
  (intern (string-upcase (format nil "~{~a~}" parts))))
 
(defun get-data ()
  (let* ((data (cl-csv:read-csv (merge-pathnames *data-files-location* *fname* )
                         :unquoted-empty-string-is-nil t
                         :trim-outer-whitespace t))
         (headers (car data))
         (rows (cdr data)))
    (setf headers (mapcar (lambda (header)
                            (read-from-string (to-kebab-case header)))
                          headers))
    (mapcar (lambda (row)
              (loop for key in headers
                    for value in row
                    collect (cons key value)))
            rows)))

(defun get-value (key case &optional (as-symbol nil))
  (let ((value (cdr (assoc key case))))
    (if as-symbol (read-from-string value)
        value)))

(defun get-descriptions (cases)
  (mapcar (lambda (case)
            (cons (get-value 'cdc-test-id case)
                  (get-value 'testcase-name case)))
          cases))

(defun get-testcase (id cases)
  (first (remove-if-not (lambda (case)
                          (eq (get-value 'cdc-test-id case t) id)) 
                        cases)))

(defmacro defstruct-with-info (name &rest slots)
  `(progn (defstruct ,name ,@slots)
          (setf (symbol-plist ',name) '(slots ,slots))))

(defmacro defreader (name)
  (let* ((make-name (intern (string-upcase (format nil "make-~a" name))))
         (reader-name (intern (string-upcase (format nil "read-~a" name))))
         (slots (getf (symbol-plist `,name ) 'slots))
         (init-forms (loop for slot in slots
                           append `(,(intern (format nil "~a" slot) "KEYWORD") (get-value ',slot testcase)))))
    `(defun ,reader-name (testcase)
       (,make-name ,@init-forms))))

(defstruct-with-info dose
                     date-administered
                     vaccine-name 
                     cvx 
                     mvx 
                     evaluation-status
                     evaluation-reason)

(defstruct-with-info patient
                     dob
                     gender
                     med-history-text
                     med-history-code
                     med-history-code-sys
                     assessment-date)

(defstruct-with-info testcase
                     cdc-test-id
                     testcase-name
                     general-description 
                     forecase-num
                     earliest-date
                     recommended-date
                     past-due-date
                     vaccine-group
                     evaluation-test-type
                     forecast-test-type
                     date-added
                     date-updated
                     reason-for-change
                     changed-in-version) 

(defreader patient)
(defreader testcase)
(defreader dose)

(defun get-dose-n-data (data n)
  (loop
    for key in (getf (symbol-plist 'dose) 'slots)
    collect (cons key (cdr (assoc (to-symbol key "-" n) data)))))

(defun read-doses (data)
  (remove-if (lambda (dose)
               (null (dose-date-administered dose)))
             (loop for n from 1 to 7
                   collect (read-dose (get-dose-n-data data n)))))
