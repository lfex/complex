(defmodule unit-cmplx-exp-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(defun z1 () (complex:new 2 0))
(defun z2 () (complex:new 2 1))

(deftest pow-real
  (is (complex:eq #(complex 1 0)
                  (complex:pow (z1) 0)))
  (is (complex:eq #(complex 2 0)
                  (complex:pow (z1) 1)))
  (is (complex:eq #(complex 4 0)
                  (complex:pow (z1) 2)))
  (is (complex:eq #(complex 8 0)
                  (complex:pow (z1) 3)))
  (is (complex:eq #(complex 16 0)
                  (complex:pow (z1) 4))))

(deftest pow-img
  (is (complex:eq #(complex 1 0)
                  (complex:pow (complex:i) 0)))
  (is (complex:eq #(complex 0 1)
                  (complex:pow (complex:i) 1)))
  (is (complex:eq #(complex -1 0)
                  (complex:pow (complex:i) 2)))
  (is (complex:eq #(complex 0 -1)
                  (complex:pow (complex:i) 3)))
  (is (complex:eq #(complex 1 0)
                  (complex:pow (complex:i) 4))))

(deftest pow-cmplx
  (is (complex:eq #(complex 1 0)
                  (complex:pow (z2) 0)))
  (is (complex:eq #(complex 2 1)
                  (complex:pow (z2) 1)))
  (is (complex:eq #(complex 3 4)
                  (complex:pow (z2) 2)))
  (is (complex:eq #(complex 2 11)
                  (complex:pow (z2) 3)))
  (is (complex:eq #(complex -7 24)
                  (complex:pow (z2) 4))))