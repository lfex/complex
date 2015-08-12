# complex

*LFE support for numbers both real and imagined*

<img src="resources/images/complex-function-crop-x250.png" />

## Introduction

This library provides complex number data types (LFE records for rectangular
and polar complex numbers) as well as many mathematical operations which
support the complex data type. For a full list of functions in the API,see
the bottom of this README file.


## Installation

Just add it to your ``rebar.config`` deps:

```erlang
  {deps, [
    ...
    {complex, ".*",
      {git, "git@github.com:lfex/complex.git", "master"}}
      ]}.
```

And then do the usual, if your LFE project has the standard ``Makefile`` and includes:

```bash
$ make
```

or, if not, use ``rebar``:

```bash
$ rebar get-deps
$ rebar compile
```

At this point, the complex library will be avialable in your project's dependencies.

## Usage

### Creating Complex Numbers

Create some new complex numbers using the standard rectangular coordinates:

```cl
> (set z1 (complex:new 4 -2))
#(complex 4 -2)
> (set z2 (complex:new 4 2))
#(complex 4 2)
```

Create complex numbers using polar coordinates:

```cl
> (set z3 (complex:new-polar 4 (* -0.5 (math:pi))))
#(complex-polar 4 -1.5707963267948966)
> (set z4 (complex:new-polar 4 (* 0.5 (math:pi))))
#(complex-polar 4 1.5707963267948966)
```

### Creating from Strings

You can also create a new complex number using a string value:

```cl
> (complex:new "4-2i")
#(complex 4 -2)
> (complex:new "4+2i")
#(complex 4 2)
```

There are rules for using complex strings, though:

* there can be no spaces in the complex string
* you must always include the real part, even if the value is zero:
  ``(complex:new "0+2i")``
* the imaginary part must always include the number, even if the
  component value is ``1``: ``(complex:new "2+1i")``

Optional usage:

* if the imaginary component is zero, you may leave it
  off: ``(complex:new "2")``
* you may use ``i``, ``j``, ``I``, or ``J`` to indicate the imaginary
  part: ``(complex:new "-4+2j")``
* you may use floating point values: ``(complex:new "1.2-3.4i")``
* you may use scientific notation:
  ``(complex:new "1.2e3-4.5e-6i")``

### Creating from Atoms

Using the same rules, you may use atoms to create a new complex number:

```cl
> (complex:new '4-2i)
#(complex 4 -2)
> (complex:new '4.3+2.1i)
#(complex 4.3 2.1)
> (complex:new '4.3e10-2.1e-20j)
#(complex 4.3e10 -2.1e-20)
```

However, do keep in mind that the use of atoms to create complex numbers
should not be done automatically in large numbers, or you run the risk
of exhuasting the Erlang atom table and thus crashing your VM.

### Convenience Functions

For the rest of the usage, we'll just ``slurp`` so that the calls are easier to type:

```cl
> (slurp "src/complex.lfe")
#(ok complex)
```

#### Printing Complex Numbers

Print the numbers we previously defined:

```cl
> (print z1)
4-2i
ok
> (print z2)
4+2i
ok
> (print z3)
0-4.0i
ok
> (print z4)
0+4.0i
ok
```

Note that ``print/1`` will convert a polar coordinate to rectangular; thus the
last two above.

#### Common Numbers

```cl
> (one)
#(complex 1 0)
> (two)
#(complex 2 0)
> (i)
#(complex 0 1)
> (pi)
#(complex 3.141592653589793 0)
> (e)
#(complex 2.718281828459045 0)
> (-pi/2)
#(complex -1.5707963267948966 0)
```

### Math

#### Powers

Using exponents to demonstrate the cyclic values of the powers of *i*:

```cl
> (print (pow (i) 0))
1+0i
ok
> (print (pow (i) 1))
0+1i
ok
> (print (pow (i) 2))
-1+0i
ok
> (print (pow (i) 3))
0-1i
ok
> (print (pow (i) 4))
1+0i
ok
```

Negative powers are supported:

```cl
> (pow (pi) -2)
#(complex 0.10132118364233778 0.0)
> (pow (two) -4)
#(complex 0.0625 0.0)
```

As are fractional powers (roots):

```cl
> (pow 16 (/ 1 2))
#(complex 4.0 0)
> (pow 16 (/ 1 4))
#(complex 2.0 0)
> (pow 16 (/ 1 8))
#(complex 1.4142135623730951 0)
```

#### Arithmatic

```cl
> (add (complex 4 2) (i))
#(complex 4 3)
> (sub (complex 4 2) (i))
#(complex 4 1)
> (mult (complex 4 2) (i))
#(complex -2 4)
> (div (complex 4 2) (i))
#(complex 2.0 -4.0)
```

Note that ``complex/2`` is an alias for ``new/2``; it just looks nicer
when not using the module name.

#### Operations

```cl
> (conj z2)
#(complex 4 -2)
> (eq z1 z2)
false
> (eq z1 (conj z2))
true
> (inv z1)
#(complex 0.2 0.1)
> (inv z2)
#(complex 0.2 -0.1)
> (modulus z1)
4.47213595499958
> (modulus z1 #(complex))
#(complex 4.47213595499958 0)
> (modulus (complex-polar 4 (math:pi)))
4
> (arg (complex-polar 4 (math:pi)))
3.141592653589793
```

```cl
> (sqrt (-one))
#(complex 0.0 1.0)
ok
> (eq (sqrt (-one)) (i))
true
```

See the [unit tests](tests) for a greater number of examples.

## API

The list of functions currently supported by the complex library are as follows:

```cl
complex:-2pi/0
complex:->atom/1
complex:->str/1
complex:-i/0
complex:-i/2/0
complex:-one/0
complex:-pi/0
complex:-pi/2/0
complex:-two/0
complex:2pi/0
complex:abs/1
complex:abs/2
complex:acos/1
complex:acosh/1
complex:acot/1
complex:acoth/1
complex:acsc/1
complex:acsch/1
complex:add/2
complex:angle/1
complex:arg/1
complex:arg/2
complex:asec/1
complex:asech/1
complex:asin/1
complex:asinh/1
complex:atan/1
complex:atanh/1
complex:atom->/1
complex:complex/2
complex:complex-polar/2
complex:complex-polar?/1
complex:complex?/1
complex:conj/1
complex:cos/1
complex:cosh/1
complex:cot/1
complex:coth/1
complex:csc/1
complex:csch/1
complex:distance/1
complex:div/2
complex:e/0
complex:eeq/2
complex:eq/2
complex:eq/3
complex:exp/1
complex:i/0
complex:i/2/0
complex:img/1
complex:inv/1
complex:ln/1
complex:modsq/1
complex:modulus/1
complex:modulus/2
complex:mult/2
complex:neg/1
complex:new/0
complex:new/1
complex:new/2
complex:new-polar/0
complex:new-polar/1
complex:new-polar/2
complex:one/0
complex:phase/1
complex:phi/1
complex:pi/0
complex:pi/2/0
complex:polar->rect/1
complex:polar->rect/2
complex:pow/2
complex:print/1
complex:r/1
complex:real/1
complex:rect->polar/1
complex:sec/1
complex:sech/1
complex:sign/1
complex:sin/1
complex:sinh/1
complex:sqrt/1
complex:str->/1
complex:sub/2
complex:tan/1
complex:tanh/1
complex:two/0
```

