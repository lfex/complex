(defmodule cmplx-util
  (export (get-version 0)
          (get-versions 0)
          (->str 1)
          (str-> 1)
          (get-match 1)
          (print-api-functions 0)
          (zero-check 2)))

(include-lib "complex/include/data-types.lfe")

(defun get-version ()
  (lutil:get-app-version 'complex))

(defun get-versions ()
  (++ (lutil:get-versions)
      `(#(complex ,(get-version)))))

;; Convert to string (list):
;;
;; > (complex:->str c1)
;; ("1" 32 "+" "2" 105)
;; > (complex:->str c2)
;; ("3" 32 () "-5" 105)

(defun ->str
  (((match-complex real r img i)) (when (>= i 0))
   (->str r i "+"))
  (((match-complex real r img i))
   (->str r i "")))

(defun ->str (r i pos)
  (io_lib:format "~p~s~pi" `(,r ,pos ,i)))

(defun str->
  ((z-atom) (when (is_atom z-atom))
   (str-> (atom_to_list z-atom)))
  ((z-str)
   (case (get-match z-str)
     (`#(match (,_ ,real))
      (complex:new (str->num real)))
     (`#(match (,_ ,real ,_ ,_))
      (complex:new (str->num real)))
     (`#(match (,_ ,real ,_ ,_ ,_))
      (complex:new (str->num real)))
     (`#(match (,_ () ,_ ,_ ,_ ,_ ,img))
      (complex:new (str->num img)))
     (`#(match (,_ () ,_ ,_ ,_ ,_ ,img ,_ ,_))
      (complex:new (str->num img)))
     (`#(match (,_ () ,_ ,_ ,_ ,_ ,img ,_ ,_ ,_))
      (complex:new (str->num img)))
     (`#(match (,_ ,real ,_ ,_ ,_ ,_ ,img))
      (complex:new (str->num real)
                   (str->num img)))
     (`#(match (,_ ,real ,_ ,_ ,_ ,_ ,img ,_ ,_))
      (complex:new (str->num real)
                   (str->num img)))
     (`#(match (,_ ,real ,_ ,_ ,_ ,_ ,img ,_ ,_ ,_))
      (complex:new (str->num real)
                   (str->num img))))))

(defun get-pattern ()
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
    (re:run z-str (get-pattern) '(#(capture all_but_first list))))

(defun str->num (num-str)
  (try (list_to_integer num-str)
    (catch (_
            (try (list_to_float num-str)
              (catch (_
                      (error `#(conversion-error ,num-str)))))))))

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
  (if (< (abs num) tol)
    0
    num))