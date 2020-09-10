(defmodule complex
  (export
    (new 0) (new 1) (new 2) (complex 2)
    (new-polar 0) (new-polar 1) (new-polar 2) (complex-polar 2)
    (complex? 1)
    (complex-polar? 1)
    (real 1)
    (img 1)
    (r 1) (distance 1)
    (phi 1) (angle 1))
  (export
    (one 0)
    (-one 0)
    (two 0)
    (-two 0)
    (i 0)
    (-i 0)
    (i/2 0)
    (-i/2 0)
    (e 0)
    (pi 0)
    (-pi 0)
    (pi/2 0)
    (-pi/2 0)
    (2pi 0)
    (-2pi 0))
  (export
    (add 2)
    (sub 2)
    (mult 2)
    (div 2))
  (export
    (sign 1)
    (neg 1)
    (eq 2) (eq 3)
    (eeq 2)
    (conj 1)
    (modsq 1)
    (modulus 1) (modulus 2)
    (abs 1) (abs 2)
    (inv 1)
    (arg 1) (arg 2)
    (phase 1)
    (sqrt 1))
  (export
    (pow 2)
    (exp 1)
    (ln 1))
  (export
    (cos 1) (cosh 1) (acos 1) (acosh 1)
    (sin 1) (sinh 1) (asin 1) (asinh 1)
    (tan 1) (tanh 1) (atan 1) (atanh 1)
    (csc 1) (csch 1) (acsc 1) (acsch 1)
    (sec 1) (sech 1) (asec 1) (asech 1)
    (cot 1) (coth 1) (acot 1) (acoth 1))
  (export
    (rect->polar 1)
    (polar->rect 1)
    (polar->rect 2))
  (compile
   #(no_auto_import '(abs 1))))

(include-lib "include/data-types.lfe")
(include-lib "include/options.lfe")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Constructors   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(defun new-polar ()
  (new-polar 1 0))

(defun new-polar (phi)
  (new-polar 1 phi))

(defun new-polar (r phi)
  (make-complex-polar mod r arg phi))

(defun complex-polar (r phi)
  (new-polar r phi))

(defun real (z)
  (complex-real z))

(defun img (z)
  (complex-img z))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Constants   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun one ()
  (complex 1 0))

(defun -one ()
  (complex -1 0))

(defun two ()
  (complex 2 0))

(defun -two ()
  (complex -2 0))

(defun i ()
  (complex 0 1))

(defun -i ()
  (complex 0 -1))

(defun i/2 ()
  (complex 0 0.5))

(defun -i/2 ()
  (complex 0 -0.5))

(defun e ()
  (complex (math:exp 1) 0))

(defun pi ()
  (complex (math:pi) 0))

(defun -pi ()
  (complex (* -1 (math:pi)) 0))

(defun pi/2 ()
  (complex (* (math:pi) 0.5) 0))

(defun -pi/2 ()
  (complex (* (math:pi) -0.5) 0))

(defun 2pi ()
  (complex (* (math:pi) 2) 0))

(defun -2pi ()
  (complex (* (math:pi) -2) 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Arithmatic   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Setup:
;;
;; lfe> (set z1 (complex:new 1 2))
;; #(complex 1 2)
;; lfe> (set z2 (complex:new 3 -5))
;; #(complex 3 -5)

;; Adding:
;;
;; lfe> (complex:add z1 z2)
;; #(complex 4 -3)
;;
(defun add
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2))
   (new (+ r1 r2) (+ i1 i2))))

;; Subtracting:
;;
;; lfe> (complex:sub z1 z2)
;; #(complex -2 7)
;; lfe> (complex:sub z2 z1)
;; #(complex 2 -7)
;; lfe> (complex:sub z1 z1)
;; #(complex 0 0)
;;
(defun sub
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2))
   (new (- r1 r2) (- i1 i2))))

;; Multiplying
;;
;; lfe> (complex:* z1 z2)
;; #(complex 13 -11)
;;
(defun mult
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2))
   (new (- (* r1 r2) (* i1 i2))
        (+ (* r1 i2) (* r2 i1)))))

;; Division:
;;
;; lfe> (complex:div z1 z2)
;; #(complex -0.20588235294117646 0.3235294117647059)
;; lfe> (complex:div z2 z1)
;; #(complex -1.4 -2.2)
;;
(defun div (z1 z2)
  (let* ((denom (complex:real (complex:modsq z2)))
         (z3 (mult z1 (complex:conj z2))))
    (complex:new (/ (complex:real z3) denom)
                 (/ (complex:img z3) denom))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Operations   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sign
  ((x) (when (< x 0))
   -1)
  ((_)
   1))

;; Negation:
;;
;; lfe> (complex:neg z1)
;; #(complex -1 -2)
;; lfe> (complex:neg z2)
;; #(complex -3 5)

(defun neg
  (((match-complex real r img i))
   (complex (* -1 r) (* -1 i))))

;; Equality:
;;
;; lfe> (complex:eq z1 z2)
;; false
;; lfe> (complex:eq z1 (complex:new 1 2))
;; true

(defun eq
  "Equal."
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2))
   (if (and (== r1 r2)
            (== i1 i2))
     'true
     'false))
  (((match-complex-polar mod r1 arg phi1)
    (match-complex-polar mod r2 arg phi2))
   (if (and (== r1 r2)
            (== phi1 phi2))
     'true
     'false)))

(defun eq
  "Equal, within a tolerance.

  Sometimes it's useful to set a tolerance level for what floating points
  numbers should be considered 0. This is done in the unit tests for this
  library, assuming any float less that 1.0e-15 to be a zero, e.g. The
  following version of the equality function take an options list or
  options record, and if the field 'tol' is present and set to something
  other than 'undefined', a tolerance check will be performed."
  ((z1 z2 '())
   (eq z1 z2))
  ((z1 z2 opts) (when (is_list opts))
   (eq z1 z2 (opts->rec opts)))
  ((z1 z2 (match-opts tol 'undefined))
   (eq z1 z2))
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2)
    (match-opts tol tol))
   (if (and (== (complex:zero-check r1 tol)
                (complex:zero-check r2 tol))
            (== (complex:zero-check i1 tol)
                (complex:zero-check i2 tol)))
     'true
     'false))
  ((z1 z2 _)
   (eq z1 z2)))

(defun eeq
  "Exactly equal."
  (((match-complex real r1 img i1)
    (match-complex real r2 img i2))
   (if (and (=:= r1 r2)
            (=:= i1 i2))
     'true
     'false)))

;; Conjugate:
;;
;; lfe> (complex:conj z1)
;; #(complex 1 -2)
;; lfe> (complex:conj z2)
;; #(complex 3 5)

(defun conj
  (((match-complex real r img i))
   (complex r (* -1 i))))

(defun modsq (z)
  (mult z (conj z)))

(defun modulus
  (((match-complex-polar mod r))
   r)
  ((z)
   (math:sqrt (real (modsq z)))))

(defun modulus
  ((z #(complex))
   (complex (modulus z) 0)))

(defun abs (z)
  (modulus z))

(defun abs (z opt)
  (modulus z opt))

;; Inverse:
;;
;; lfe> (complex:inv z1)
;; #(complex 0.2 -0.4)
;; lfe> (complex:inv z2)
;; #(complex 0.08823529411764706 0.14705882352941177)

(defun inv (z)
  (div (conj z) (modsq z)))

(defun arg
  (((match-complex real r img i))
   (arg r i))
  (((match-complex-polar arg phi))
   phi))

(defun arg
  ;; ((r i) (when (> r 0))
  ;;  (math:atan2 i r))
  ;; ((r i) (when (and (< r 0) (< i 0)))
  ;;  (- (math:atan2 i r) (math:pi)))
  ;; ((r i) (when (and (< r 0) (>= i 0)))
  ;;  (+ (math:atan2 i r) (math:pi)))
  ((r i) (when (andalso (== r 0) (== i 0)))
   'undefined)
  ((r i)
   (math:atan2 i r))
  ;; ((r i) (when (and (== r 0) (> i 0)))
  ;;  (/ (math:pi) 2))
  ;; ((r i) (when (and (== r 0) (< i 0)))
  ;;  (/ (math:pi -2)))
  )

(defun phase (z)
  (arg z))

;; Square Root:
;;
;; lfe> (complex:sqrt (complex:new -1 0))
;; #(complex 0.0 1.0)
;; lfe> (complex:sqrt z1)
;; #(complex 1.7320508075688772 1.4142135623730951)
;; lfe> (complex:sqrt z2)
;; #(complex 4.301162633521313 -3.9370039370059056)

(defun sqrt
  (((= (match-complex real r img i) z))
   (let* ((abs-z (abs z))
          (neg-r (* -1 r))
          (r2 (math:sqrt (/ (+ r abs-z) 2)))
          (i2 (* (sign i) (math:sqrt (/ (+ neg-r abs-z) 2)))))
     (complex r2 i2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Exponential Functions   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun pow
  ((_ 0)
   (complex:one))
  ((z n) (when (is_integer z))
   (complex:new (math:pow z n) 0))
  ((z n) (when (>= n 1))
   (positive-integer-powers z n))
  ((z n) (when (and (> n -1) (< n 1)))
   (root z n))
  ((z n) (when (=< n -1))
   (negative-integer-powers z n)))

(defun positive-integer-powers (z n)
  (lists:foldl (lambda (x acc)
                 (mult x acc))
               (one)
               (lists:duplicate n z)))

(defun negative-integer-powers (z n)
  (complex:div (one)
               (positive-integer-powers z (abs n))))

(defun root (z n)
  (cond
   ((complex? z)
    (root-rect z n))
   ((complex-polar? z)
    (root-polar z n))
   ('true
    (complex:new (math:pow z n) 0))))

(defun root-rect
  ((z 0.5)
   (complex:sqrt z))
  ((z n)
   (root-polar (rect->polar z) n)))

(defun root-polar
  (((match-complex-polar mod r arg phi) n)
   (mult (complex (math:pow r n) 0)
         (complex (math:cos (* phi n))
                  (math:sin (* phi n))))))

(defun exp
  (((match-complex real r img i))
   (complex (* (math:exp r) (math:cos i))
            (* (math:exp r) (math:sin i)))))

(defun ln
  (((= (match-complex real r img i) z))
   (complex (math:log (modulus z))
            (arg z))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Trigonometric Functions   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sin
  (((match-complex real r img i))
   (complex (* (math:sin r) (math:cosh i))
            (* (math:cos r) (math:sinh i)))))

(defun cos
  (((match-complex real r img i))
   (complex (* (math:cos r) (math:cosh i))
            (* -1 (math:sin r) (math:sinh i)))))

(defun tan (z)
  (div (sin z)
       (cos z)))

(defun csc (z)
  (div (one)
       (sin z)))

(defun sec (z)
  (div (one)
       (cos z)))

(defun cot (z)
  (div (one)
       (tan z)))

;; Hyperbolic trigonometric functions

(defun sinh
  (((match-complex real r img i))
   (complex (* (math:sinh r) (math:cos i))
            (* (math:cosh r) (math:sin i)))))

(defun cosh
  (((match-complex real r img i))
   (complex (* (math:cosh r) (math:cos i))
            (* -1 (math:sinh r) (math:sin i)))))

(defun tanh (z)
  (div (sinh z)
       (cosh z)))

(defun csch (z)
  (div (one)
       (sinh z)))

(defun sech (z)
  (div (one)
       (cosh z)))

(defun coth (z)
  (div (one)
       (tanh z)))

;; Inverse trigonometric functions

(defun asin (z)
  (mult
   (-i)
   (ln (add (mult z (i))
            (sqrt
             (sub (one) (pow z 2)))))))

(defun acos (z)
  (mult
   (-i)
   (ln (add z (mult (i)
                    (sqrt
                     (sub (one)
                          (pow z 2))))))))

(defun atan (z)
  (mult
   (i/2)
   (ln (div (add (i) z)
            (sub (i) z)))))

(defun acsc (z)
  (mult
   (-i)
   (ln (add (div (i) z)
            (sqrt (sub (one)
                       (div (one)
                            (pow z 2))))))))

(defun asec (z)
  (mult
   (i)
   (ln (div (add (one)
                 (sqrt
                  (sub (one) (pow z 2))))
            z))))

(defun acot (z)
  (sub
   (mult
    (i/2)
    (ln (sub (one) (div (i) z))))
   (mult
    (i/2)
    (ln (add (one) (div (i) z))))))

;; Inverse hyperbolic trigonometric functions

(defun asinh (z)
  (ln (add z
           (sqrt
            (add (one) (pow z 2))))))

(defun acosh (z)
  (ln (add z (mult
              (sqrt (sub z (one)))
              (sqrt (add z (one)))))))

(defun atanh (z)
  (add
   (div (ln (sub (one) z))
        (-two))
   (div (ln (add (one) z))
        (two))))

(defun acsch (z)
  (ln (add
       (sqrt (add (one)
                  (div (one)
                       (pow z 2))))
       (div (one) z))))

(defun asech (z)
  (ln (add
       (mult
        (sqrt (sub
               (div (one) z)
               (one)))
        (sqrt (add
               (div (one) z)
               (one))))
       (div (one) z))))

(defun acoth (z)
  (add
   (div (ln (sub (one)
                 (div (one) z)))
        (-two))
   (div (ln (add (one)
                 (div (one) z)))
        (two))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Polar Functions   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun r (z-polar)
  (complex-polar-mod z-polar))

(defun distance (z-polar)
  (r z-polar))

(defun phi (z-polar)
  (complex-polar-arg z-polar))

(defun angle (z-polar)
  (phi z-polar))

(defun rect->polar (z)
  (new-polar (modulus z)
             (arg z)))

(defun polar->rect
  (((= (match-complex-polar) polar))
   (polar->rect (r polar)
                (phi polar)))
  ((phi)
   (polar->rect 1 phi)))

(defun polar->rect (r phi)
  (new (* r (math:cos phi))
       (* r (math:sin phi))))

(defun complex? (z)
  (is-complex z))

(defun complex-polar? (z-polar)
  (is-complex-polar z-polar))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Display   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Pretty-print:
;;
;; lfe> (complex:format c1)
;; 1+2i
;; ok
;; lfe> (complex:format c2)
;; 3-5i
;; ok

(defun format
  (((= (match-complex) z))
   (io:format (++ (cmplx-util:->str z) "~n")))
  (((= (match-complex-polar) polar))
   (format (polar->rect polar)))
  ((x)
   (io:format "~p~n" (list x))))
