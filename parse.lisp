;;;; Parsers for json objects from the API
;;;;
;;;; The various parsers return nil if the string doesn't parse.

(in-package #:cl-cdsi-parse)

(defparameter *interval-re* "[a-zA-Z]+|[-+]?\\d+")
(defparameter *invalid-chars* "[sS\\s]")

(defun as-number (thing)
  (handler-case
      (parse-integer thing)
    (sb-int:simple-parse-error () (parse-float thing))))

(defun as-keyword (thing)
  (if (not (equal "" thing))
      (intern (string-upcase (kebab:to-kebab-case thing)) "KEYWORD")
      nil))

(defun as-boolean (thing)
  (cond ((numberp thing) (not (eq 0 thing)))
        ((stringp thing) (not (not (ppcre:scan "^[YyTt]" thing))))
        (t thing)))

(defun as-date (thing)
  (local-time:parse-timestring thing))

(defun as-interval (str)
  "Parse a string of the form '12 days - 4 months' into a list of plists."
  (let ((tokens (ppcre:all-matches-as-strings
                 *interval-re*
                 (ppcre:regex-replace-all *invalid-chars* str ""))))
    (loop :for (a b) :on tokens :by #'cddr
          :while b
          :collect (list :amount (as-number a)
                         :unit (as-keyword b)))))
