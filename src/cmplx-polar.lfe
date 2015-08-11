(defmodule cmplx-polar
  (export (rect->polar 1)
          (polar->rect 1) (polar->rect 2)))

(include-lib "complex/include/data-types.lfe")

(defun rect->polar (z)
  (complex:new-polar (complex:modulus z)
                     (complex:arg z)))

(defun polar->rect
  (((= (match-complex-polar) polar))
   (polar->rect (complex:r polar)
                (complex:phi polar)))
  ((phi)
   (polar->rect 1 phi)))

(defun polar->rect (r phi)
  (complex:new (* r (math:cos phi))
               (* r (math:sin phi))))
