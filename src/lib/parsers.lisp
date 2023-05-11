(in-package :cdsi.lib)

(defun parse-bool (x)
  (not (or (null x)
           (equal 0 x)
           (equal "" x)
           (equal "No" x)
           (equal "N" x)
           (equal "F" (format nil "~:@(~a~)" x))
           (equal "FALSE" (format nil "~:@(~a~)" x)))))

;;;; Parse dates "MM/DD/YYYY"

(defun parse-date (s)
  "Parse a date of the form 'MM/DD/YYYY'"
  (let* ((parts (ppcre:split "/" s))
         (date-parts (mapcar #'parse-integer parts)))
    (make-date (third date-parts) (first date-parts) (second date-parts))))

;;;; Parse intrvals "1 year - 4 days"

(defun parse-interval (s)
  "Return a list of intervals parsed from the string."
  (if (or (string= "" s) (null s))
      nil
      (let ((str2 (ppcre:regex-replace-all "[sS\\s]" s ""))
            result)
        (ppcre:do-register-groups ((#'parse-integer value) (#'parse-keyword unit))
          ("([+-]?\\d+)(\\w+)" str2)
          (push (make-interval value unit) result))
        (nreverse result))))
