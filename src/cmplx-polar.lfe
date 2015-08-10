(defmodule cmplx-polar
  (export (rect->polar 1)
          (polar->rect 1) (polar->rect 2)))

(include-lib "complex/include/data-types.lfe")

(defun rect->polar (z)
  'noop)

(defun polar->rect (phi)
  (polar->rect 1 phi))

(defun polar->rect (r phi)
  (complex:new (* r (math:cos phi))
               (* r (math:sin phi))))
