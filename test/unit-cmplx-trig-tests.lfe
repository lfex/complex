(defmodule unit-cmplx-trig-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(defun z1 ()
  (complex:new (math:pi) 1))

(defun z2 ()
  (complex:new 1 (/ (math:pi) 2)))

;; Trigonometric functions

(deftest sin
  (is (complex:eq #(complex 0 -1.1752011936438014)
                  (complex:sin (z1))
                  '(#(tol 1.0e-15)))))

(deftest cos
  (is (complex:eq #(complex -1.5430806348152437 0)
                  (complex:cos (z1))
                  '(#(tol 1.0e-15)))))

(deftest tan
  (is (complex:eq #(complex 0 0.7615941559557649)
                  (complex:tan (z1))
                  '(#(tol 1.0e-15)))))

(deftest csc
  (is (complex:eq #(complex 0 0.8509181282393217)
                  (complex:csc (z1))
                  '(#(tol 1.0e-15)))))

(deftest sec
  (is (complex:eq #(complex -0.6480542736638853 0)
                  (complex:sec (z1))
                  '(#(tol 1.0e-15)))))

(deftest cot
  (is (complex:eq #(complex 0 -1.3130352854993315)
                  (complex:cot (z1))
                  '(#(tol 1.0e-15)))))

;; Hyperbolic trigonometric functions

(deftest sinh
  (is (complex:eq #(complex 0 1.5430806348152437)
                  (complex:sinh (z2))
                  '(#(tol 1.0e-15)))))

(deftest cosh
  (is (complex:eq #(complex 0 -1.1752011936438014)
                  (complex:cosh (z2))
                  '(#(tol 1.0e-15)))))

(deftest tanh
  (is (complex:eq #(complex -1.3130352854993315 0)
                  (complex:tanh (z2))
                  '(#(tol 1.0e-15)))))

(deftest csch
  (is (complex:eq #(complex 0 -0.6480542736638853)
                  (complex:csch (z2))
                  '(#(tol 1.0e-15)))))

(deftest sech
  (is (complex:eq #(complex 0 0.8509181282393217)
                  (complex:sech (z2))
                  '(#(tol 1.0e-15)))))

(deftest coth
  (is (complex:eq #(complex -0.7615941559557649 0)
                  (complex:coth (z2))
                  '(#(tol 1.0e-15)))))