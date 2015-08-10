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

(deftest exp
  (is (complex:eq #(complex 2.718281828459045 0)
                  (complex:exp (complex:one))))
  (is (complex:eq #(complex 0.5403023058681398 0.8414709848078965)
                  (complex:exp (complex:i)))))

(deftest ln
  (is (complex:eq #(complex 0.0 1.5707963267948966)
                  (complex:ln (complex:i))))
  (is (complex:eq #(complex 0.0 0.0)
                  (complex:ln (complex:one))))
  (is (complex:eq #(complex 0.6931471805599453 0.0)
                  (complex:ln (complex:new 2 0)))))

(deftest exp-ln-equality
  (is (complex:eq (complex:i)
                  (complex:ln
                   (complex:exp
                    (complex:i)))))
  (is (complex:eq (complex:i)
                  (complex:exp
                   (complex:ln
                    (complex:i)))
                  '(#(tol 1.0e-15)))))