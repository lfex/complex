(defmodule cmplx-io
  (export (print 1)))

(include-lib "complex/include/data-types.lfe")

;; Pretty-print:
;;
;; > (complex:print c1)
;; 1+2i
;; ok
;; > (complex:print c2)
;; 3-5i
;; ok

(defun print
  (((= (match-complex) z))
   (io:format (++ (cmplx-util:->str z) "~n")))
  (((= (match-complex-polar) polar))
   (print (complex:polar->rect polar)))
  ((x)
   (io:format "~p~n" (list x))))