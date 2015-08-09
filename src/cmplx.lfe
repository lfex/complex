(defmodule cmplx
  (export (new 0) (new 1) (new 2) (new 3)
          (complex 2)))

(include-lib "complex/include/data-types.lfe")
(include-lib "complex/include/options.lfe")

(defun new ()
  (new 0 0))

(defun new (r)
  (new r 0))

(defun new (r i)
  (make-complex real r img i))

(defun new
  ((r i '())
   (new r i))
  ((r i (match-opts tol 'undefined))
   (new r i))
  ((r i (match-opts tol tol))
   (new (complex:zero-check r tol)
        (complex:zero-check i tol)))
  ((r i _)
   (new r i)))

(defun complex (r i)
  "This function is an alias for new/2 and is provided for aesthetic reasons:
  it will look nicer in the REPL calling (complex 1 2) than (new 1 2)."
  (new r i))