(defmodule cmplx
  (export (new 0) (new 1) (new 2)
          (complex 2)
          (complex? 1)
          (real 1)
          (imag 1)))

(include-lib "complex/include/data-types.lfe")
(include-lib "complex/include/options.lfe")

(defun new ()
  (new 0 0))

(defun new
  ((z-str) (when (is_list z-str))
   (cmplx-util:str-> z-str))
  ((z-atom) (when (is_atom z-atom))
   (cmplx-util:atom-> z-atom))
  ((r)
   (new r 0)))

(defun new (r i)
  (make-complex real r img i))

(defun complex (r i)
  "This function is an alias for new/2 and is provided for aesthetic reasons:
  it will look nicer in the REPL calling (complex 1 2) than (new 1 2)."
  (new r i))

(defun complex? (z)
  (is-complex z))

(defun real (z)
  (complex-real z))

(defun imag (z)
  (complex-img z))