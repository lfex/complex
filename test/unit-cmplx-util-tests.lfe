(defmodule unit-cmplx-util-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest ->str
  (is-equal '("1" 32 "+" "2" 105)
            (complex:->str (unit-cmplx-tests:c1)))
  (is-equal '("3" 32 "" "-5" 105)
            (complex:->str (unit-cmplx-tests:c2)))
  (is-equal '("-1" 32 "+" "0" 105)
            (complex:->str (unit-cmplx-tests:c3)))
  (is-equal '("-4" 32 "" "-2" 105)
            (complex:->str (unit-cmplx-tests:c4))))


(deftest str->
  ;; Just real
  (is-equal #(complex 1 0) (complex:str-> "1"))
  (is-equal #(complex 10 0) (complex:str-> "10"))
  (is-equal #(complex -1 0) (complex:str-> "-1"))
  (is-equal #(complex -10 0) (complex:str-> "-10"))
  (is-equal #(complex 1 0) (complex:str-> "+1"))
  (is-equal #(complex 10 0) (complex:str-> "+10"))
  ;; Just img
  (is-equal #(complex 0 1) (complex:str-> "1i"))
  (is-equal #(complex 0 10) (complex:str-> "10i"))
  (is-equal #(complex 0 -1) (complex:str-> "-1i"))
  (is-equal #(complex 0 -10) (complex:str-> "-10i"))
  (is-equal #(complex 0 1) (complex:str-> "+1i"))
  (is-equal #(complex 0 10) (complex:str-> "+10i"))
  ;; Both
  (is-equal #(complex 4 2) (complex:str-> "4 2i"))
  (is-equal #(complex -4 -2) (complex:str-> "-4 -2i"))
  (is-equal #(complex 4 2) (complex:str-> "+4 +2i")))
