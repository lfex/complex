(defmodule cmplx
  (export (new 0) (new 1) (new 2)
          (complex 2)))

(include-lib "complex/include/data-types.lfe")

(defun new ()
  (new 0 0))

(defun new (r)
  (new r 0))

(defun new (r i)
  (make-complex real r img i))

(defun complex (r i)
  "This function is an alias for new/2 and is provided for aesthetic reasons:
  it will look nicer in the REPL calling (complex 1 2) than (new 1 2)."
  (new r i))