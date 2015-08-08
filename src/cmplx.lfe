(defmodule cmplx
  (export (new 0) (new 1) (new 2)))

(include-lib "complex/include/data-types.lfe")

(defun new ()
  (new 0 0))

(defun new (r)
  (new r 0))

(defun new (r i)
  (make-complex real r img i))