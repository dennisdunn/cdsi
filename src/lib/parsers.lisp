(in-package :cdsi.parse)

(defgeneric parse (text output-type &optional arg)
  (:documentation "Parse the source text."))

(defmethod parse ((text string) (output-type (eql :string)) &optional (arg nil))
  (declare (ignoreable output-type arg))
  text)

(defmethod parse ((text string) (output-type (eql :number)) &optional (arg nil))
  (declare (ignoreable output-type arg))
  (read-from-string text))

(defmethod parse ((text string) (output-type (eql :bool)) &optional (arg nil))
  (declare (ignoreable output-type arg))
  (not (or (null text)
           (equal 0 text)
           (equal "" text)
           (search text "NoFalse" :test #'char-equal))))

(defmethod parse ((text number) (output-type (eql :bool)) &optional (arg nil))
  (declare (ignoreable output-type arg))
  (not (= 0 text)))

(defmethod parse ((text string) (output-type (eql :common-date)) &optional (arg nil))
  "MM/DD/YYYY"
  (declare (ignoreable output-type arg))
  (let ((parts (split-to-integers text "/")))
    (make-date :year (third parts) :month (first parts) :day (second parts))))

(defmethod parse ((text string) (output-type (eql :iso-date)) &optional (arg nil))
  "YYYY-MM-DDT00:00:00 (ignore the time portion)"
  (declare (ignoreable output-type arg))
  (let ((parts (split-to-integers text "-")))
    (make-date :year (first parts) :month (second parts) :day (third parts))))

(defmethod parse ((text string) (output-type (eql :interval)) &optional (arg nil))
  "Return a list of intervals parsed from a string of the form '1 year - 4 days'."
  (declare (ignoreable output-type arg))
  (unless (or (string= "" text) (null text))
    (let ((str2 (ppcre:regex-replace-all "[sS\\s]" text ""))
          result)
      (ppcre:do-register-groups ((#'parse-integer value) (#'(lambda (str) (parse str :keyword)) unit))
                                ("([+-]?\\d+)(\\w+)" str2)
                                (push (make-interval value unit) result))
      (nreverse result))))

(defmethod parse ((text string) (output-type (eql :keyword)) &optional (arg 1)) 
  "Intern a symbol named by the argument into the KEYWORD package.

   If arg is anything other than 1, add an 'S' to the name of the symbol."
  (declare (ignoreable output-type))
  (intern (format nil "~:@(~a~p~)" (kebab:to-kebab-case text) arg) :keyword)) 

(defun split-to-integers (text delimiter)
  "Split the string and return a list of integers."
  (mapcar #'(lambda (str) (parse-integer str :junk-allowed t)) (ppcre:split delimiter text)))

