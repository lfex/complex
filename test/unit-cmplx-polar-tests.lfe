(defmodule unit-cmplx-polar-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest polar->rect
  (is (complex:eq #(complex 0 1)
                  (complex:polar->rect (/ (math:pi) 2))
                  '(#(tol 1e-15))))
  (is (complex:eq #(complex 0 -1)
                  (complex:polar->rect -1 (/ (math:pi) 2))
                  '(#(tol 1e-15))))
  (is (complex:eq #(complex -1 0)
                  (complex:polar->rect (math:pi))
                  '(#(tol 1e-15))))
  (is (complex:eq #(complex 1 0)
                  (complex:polar->rect -1 (math:pi))
                  '(#(tol 1e-15)))))