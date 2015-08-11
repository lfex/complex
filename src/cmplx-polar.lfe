(defmodule cmplx-polar
  (export (rect->polar 1)
          (polar->rect 1) (polar->rect 2)))

(defun rect->polar (z)
  (complex:new-polar (complex:modulus z)
                     (complex:arg z)))

(defun polar->rect (phi)
  (polar->rect 1 phi))

(defun polar->rect (r phi)
  (complex:new (* r (math:cos phi))
               (* r (math:sin phi))))
