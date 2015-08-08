(defmodule cmplx-util
  (export all))

(include-lib "complex/include/data-types.lfe")

(defun get-version ()
  (lutil:get-app-version 'complex))

(defun get-versions ()
  (++ (lutil:get-versions)
      `(#(complex ,(get-version)))))

;; Convert to string (list):
;;
;; > (complex:->str c1)
;; ("1" 32 "+" "2" 105)
;; > (complex:->str c2)
;; ("3" 32 () "-5" 105)

(defun ->str
  (((match-complex real r img i)) (when (>= i 0))
   (->str r i "+"))
  (((match-complex real r img i))
   (->str r i "")))

(defun ->str (r i pos)
  (io_lib:format "~p ~s~pi" `(,r ,pos ,i)))