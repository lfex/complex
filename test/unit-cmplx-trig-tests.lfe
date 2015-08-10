(defmodule unit-cmplx-trig-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(defun z ()
  (complex:new (math:pi) 1))

(deftest sin
  (is (complex:eq #(complex 0 -1.1752011936438014)
                  (complex:sin (z))
                  '(#(tol 1.0e-15)))))

(deftest cos
  (is (complex:eq #(complex -1.5430806348152437 0)
                  (complex:cos (z))
                  '(#(tol 1.0e-15)))))

(deftest tan
  (is (complex:eq #(complex 0 0.7615941559557649)
                  (complex:tan (z))
                  '(#(tol 1.0e-15)))))

(deftest csc
  (is (complex:eq #(complex 0 0.8509181282393217)
                  (complex:csc (z))
                  '(#(tol 1.0e-15)))))

(deftest sec
  (is (complex:eq #(complex -0.6480542736638853 0)
                  (complex:sec (z))
                  '(#(tol 1.0e-15)))))

(deftest cot
  (is (complex:eq #(complex 0 -1.3130352854993315)
                  (complex:cot (z))
                  '(#(tol 1.0e-15)))))
