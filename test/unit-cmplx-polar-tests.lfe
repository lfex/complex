(defmodule unit-cmplx-polar-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

;; XXX failing!
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

(deftest rect->polar
  (is (complex:eq `#(complex-polar 1 ,(/ (math:pi) 2))
                  (complex:rect->polar (complex:new 0 1)))))