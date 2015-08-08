(defmodule cmplx-exp
  (export (exp 2)))

(include-lib "complex/include/data-types.lfe")

(defun exp (z n)
  (lists:foldl (lambda (x acc)
                 (complex:mult acc x))
               (complex:unity)
               (lists:duplicate n z)))