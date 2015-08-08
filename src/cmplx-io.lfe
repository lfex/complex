(defmodule cmplx-io
  (export (print 1)))

;; Pretty-print:
;;
;; > (complex:print c1)
;; 1+2i
;; ok
;; > (complex:print c2)
;; 3-5i
;; ok

(defun print (cmplx)
  (io:format (++ (cmplx-util:->str cmplx) "~n")))