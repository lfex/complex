(defmodule cmplx-util
  (export
    (get-version 0)
    (get-versions 0)
    (->str 1)
    (str-> 1)
    (->atom 1)
    (atom-> 1)
    (get-match 1)
    (print-api-functions 0)
    (zero-check 2)))

(include-lib "include/data-types.lfe")

(defun get-version ()
  (rebar3_lfe_version:app_version 'complex))

(defun get-versions ()
  (rebar3_lfe_version:versions '(complex)))

;; Convert to string (list):
;;
;; lfe> (complex:->str c1)
;; ("1" 32 "+" "2" 105)
;; lfe> (complex:->str c2)
;; ("3" 32 () "-5" 105)

(defun ->str
  (((match-complex real r img i)) (when (>= i 0))
   (->str r i "+"))
  (((match-complex real r img i))
   (->str r i "")))

(defun ->str (r i pos)
  (io_lib:format "~p~s~pi" `(,(zero-check r 1.0e-15)
                             ,pos
                             ,(zero-check i 1.0e-15))))

(defun ->atom
  (((match-complex real r img i)) (when (>= i 0))
   (list_to_atom (->str r i "+")))
  (((match-complex real r img i))
   (list_to_atom (->str r i ""))))

(defun str->
  ((z-str)
   (let ((match (get-match z-str)))
     ;;(io:format "Match: ~p~n" (list match)) ; debug
     (case match
       (`#(match (,_ ,real))
        (complex:new (str->num real)))
       (`#(match (,_ ,real ,_ ,_))
        (complex:new (str->num real)))
       (`#(match (,_ ,real ,_ ,_ ,_))
        (complex:new (str->num real)))
       (`#(match (,_ "" ,_ ,_ ,_ ,_ ,img))
        (complex:new 0 (str->num img)))
       (`#(match (,_ "" ,_ ,_ ,_ ,_ ,img ,_ ,_))
        (complex:new 0 (str->num img)))
       (`#(match (,_ "" ,_ ,_ ,_ ,_ ,img ,_ ,_ ,_))
        (complex:new 0 (str->num img)))
       (`#(match (,_ ,real ,_ ,_ ,_ ,_ ,img))
        (complex:new (str->num real)
                     (str->num img)))
       (`#(match (,_ ,real ,_ ,_ ,_ ,_ ,img ,_ ,_))
        (complex:new (str->num real)
                     (str->num img)))
       (`#(match (,_ ,real ,_ ,_ ,_ ,_ ,img ,_ ,_ ,_))
        (complex:new (str->num real)
                     (str->num img)))
       (`#(error ,msg)
        `#(error ,msg))
       (_ #(error conversion-failure))))))

(defun str->num (num-str)
  (try (list_to_integer num-str)
    (catch ((tuple _ _ _)
            (try (list_to_float num-str)
              (catch ((tuple _ _ _)
                      (error `#(conversion-error ,num-str)))))))))

(defun atom-> (atom)
  (str-> (atom_to_list atom)))

(defun get-img-pattern ()
  (let* ((begin "^(")
         (end ")$")
         (sign "([-+])?")
         (int "\\d+")
         (frac "(\\.\\d+)")
         (sci "([eE][+-]?\\d+)?")
         (img (++ "((" sign int "(" frac sci ")?)[iIjJ])?")))
    (get-pattern
     (re:compile (++ begin img end)))))

(defun get-full-pattern ()
  (let* ((begin "^(")
         (end ")$")
         (sign "[-+]")
         (int "\\d+")
         (frac "(\\.\\d+)")
         (sci "([eE][+-]?\\d+)?")
         (real (++ "(" sign "?" int "(" frac sci ")?)?"))
         (img (++ "((" sign int "(" frac sci ")?)[iIjJ])?")))
    (get-pattern
     (re:compile (++ begin real img end)))))

(defun get-pattern
  ((`#(ok ,pattern))
   pattern)
  ((x)
   `#(error ,x)))

(defun get-match (z-str)
  (let ((full (re:run z-str (get-full-pattern) '(#(capture all_but_first list)))))
    (case full
      (`#(match ,_) full)
      (_ (let ((img (re:run z-str (get-img-pattern) '(#(capture all_but_first list)))))
           ;;(io:format "Got img match: ~p~n" (list img)) ; debug
           (case img
             (`#(match (,_ ,_ ,img)) `#(match ("" "" "" "" "" "" ,img)))
             (_ '#(error complex-number-parse-failure))))))))

(defun check-function
  ((`#(,func-name ,arity))
   (let ((skip '(module_info
                 get-version
                 get-versions
                 loaded-complex-data-types
                 loaded-complex-options
                 loaded-complex-api
                 loaded-complex
                 zero-check
                 get-match
                 print-api-functions)))
     (if (lists:member func-name skip)
       'false
       `#(true #(,func-name ,arity))))))

(defun get-api-functions ()
  (lists:filtermap
   #'check-function/1
   (proplists:get_value 'exports (complex:module_info))))

(defun print-function
  ((`#(,func-name ,arity))
   (lfe_io:format "complex:~p/~p~n" `(,func-name ,arity))))

(defun print-api-functions ()
  (lists:foreach
   #'print-function/1
   (lists:sort (get-api-functions))))

(defun zero-check (num tol)
  (if (< (erlang:abs num) tol)
    0
    num))
