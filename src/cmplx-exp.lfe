(defmodule cmplx-exp
  (export (pow 2)
          (exp 1)
          (ln 1)))

(include-lib "complex/include/data-types.lfe")

(defun pow (z n)
  (lists:foldl (lambda (x acc)
                 (complex:mult x acc))
               (complex:one)
               (lists:duplicate n z)))

(defun exp
  (((match-complex real r img i))
   (complex:new (* (math:exp r) (math:cos i))
                (* (math:exp r) (math:sin i)))))

(defun ln
  (((= (match-complex real r img i) z))
   (complex:new (math:log (complex:abs z))
                (complex:arg z))))