# complex

[![Build Status][travis badge]][travis] [![LFE Versions][lfe badge]][lfe] [![Erlang Versions][erlang badge]][versions] [![Tags][github tags badge]][github tags] [![Downloads][hex downloads]][hex package]

*LFE support for numbers both real and imagined*

[![Complex project logo][logo]][logo-large]

## Table of Contents

* [Introduction](#introduction-)
* [Installation](#installation-)
* [Usage](#usage-)
  * [Creating Complex Numbers](#creating-complex-numbers-)
    * [From Strings](#creating-from-strings-)
    * [From Atoms](#creating-from-atoms-)
  * [Convenience Functions](#convenience-functions-)
    * [Printing](#printing-complex-numbers-)
    * [Common Numbers](#common-numbers-)
  * [Math](#math-)
    * [Arithmatic](#arithmatic-)
    * [Operations](#operations-)
    * [Powers](#powers-)
* [API](#api-)
* [License](#license-)

## Introduction [&#x219F;](#table-of-contents)

This library provides complex number data types (LFE records for rectangular
and polar complex numbers) as well as many mathematical operations which
support the complex data type. For a full list of functions in the API,see
the bottom of this README file.

## Installation [&#x219F;](#table-of-contents)

Just add it to your `rebar.config` deps:

```erlang
{deps, [
    {complex, {git, "https://github.com/lfex/complex.git", {branch, "master"}}}
  ]}.
```

At this point, the complex library will be avialable in your project's dependencies.

## Usage [&#x219F;](#table-of-contents)

### Creating Complex Numbers [&#x219F;](#table-of-contents)

Create some new complex numbers using the standard rectangular coordinates:

```lisp
lfe> (set z1 (complex:new 4 -2))
#(complex 4 -2)
lfe> (set z2 (complex:new 4 2))
#(complex 4 2)
```

Create complex numbers using polar coordinates:

```lisp
lfe> (set z3 (complex:new-polar 4 (* -0.5 (math:pi))))
#(complex-polar 4 -1.5707963267948966)
lfe> (set z4 (complex:new-polar 4 (* 0.5 (math:pi))))
#(complex-polar 4 1.5707963267948966)
```

#### Creating from Strings [&#x219F;](#table-of-contents)

You can also create a new complex number using a string value:

```lisp
lfe> (complex:new "4-2i")
#(complex 4 -2)
lfe> (complex:new "4+2i")
#(complex 4 2)
```

There are rules for using complex strings, though:

* there can be no spaces in the complex string
* you must always include the real part, even if the value is zero:
  `(complex:new "0+2i")`
* the imaginary part must always include the number, even if the
  component value is `1`: `(complex:new "2+1i")`

Optional usage:

* if the imaginary component is zero, you may leave it
  off: `(complex:new "2")`
* you may use `i`, `j`, `I`, or `J` to indicate the imaginary
  part: `(complex:new "-4+2j")`
* you may use floating point values: `(complex:new "1.2-3.4i")`
* you may use scientific notation:
  `(complex:new "1.2e3-4.5e-6i")`

#### Creating from Atoms [&#x219F;](#table-of-contents)

Using the same rules, you may use atoms to create a new complex number:

```lisp
lfe> (complex:new '4-2i)
#(complex 4 -2)
lfe> (complex:new '4.3+2.1i)
#(complex 4.3 2.1)
lfe> (complex:new '4.3e10-2.1e-20j)
#(complex 4.3e10 -2.1e-20)
```

However, do keep in mind that the use of atoms to create complex numbers
should not be done automatically in large numbers, or you run the risk
of exhuasting the Erlang atom table and thus crashing your VM.

### Convenience Functions [&#x219F;](#table-of-contents)

For the rest of the usage, we'll just `slurp` so that the calls are easier to type:

```lisp
lfe> (slurp "src/complex.lfe")
#(ok complex)
```

#### Printing Complex Numbers [&#x219F;](#table-of-contents)

Print the numbers we previously defined:

```lisp
lfe> (format z1)
4-2i
ok
lfe> (format z2)
4+2i
ok
lfe> (format z3)
0-4.0i
ok
lfe> (format z4)
0+4.0i
ok
```

Note that `format/1` will convert a polar coordinate to rectangular; thus the
last two above.

#### Common Numbers [&#x219F;](#table-of-contents)

```lisp
lfe> (one)
#(complex 1 0)
lfe> (two)
#(complex 2 0)
lfe> (i)
#(complex 0 1)
lfe> (pi)
#(complex 3.141592653589793 0)
lfe> (e)
#(complex 2.718281828459045 0)
lfe> (-pi/2)
#(complex -1.5707963267948966 0)
```

### Math [&#x219F;](#table-of-contents)

#### Arithmatic [&#x219F;](#table-of-contents)

```lisp
lfe> (add (complex 4 2) (i))
#(complex 4 3)
lfe> (sub (complex 4 2) (i))
#(complex 4 1)
lfe> (mult (complex 4 2) (i))
#(complex -2 4)
lfe> (div (complex 4 2) (i))
#(complex 2.0 -4.0)
```

Note that `complex/2` is an alias for `new/2`; it just looks nicer
when not using the module name.

#### Operations [&#x219F;](#table-of-contents)

```lisp
lfe> (conj z2)
#(complex 4 -2)
lfe> (eq z1 z2)
false
lfe> (eq z1 (conj z2))
true
lfe> (inv z1)
#(complex 0.2 0.1)
lfe> (inv z2)
#(complex 0.2 -0.1)
lfe> (modulus z1)
4.47213595499958
lfe> (modulus z1 #(complex))
#(complex 4.47213595499958 0)
lfe> (modulus (complex-polar 4 (math:pi)))
4
lfe> (arg (complex-polar 4 (math:pi)))
3.141592653589793
```

```lisp
lfe> (sqrt (-one))
#(complex 0.0 1.0)
ok
lfe> (eq (sqrt (-one)) (i))
true
```

#### Powers [&#x219F;](#table-of-contents)

Using exponents to demonstrate the cyclic values of the powers of *i*:

```lisp
lfe> (format (pow (i) 0))
1+0i
ok
lfe> (format (pow (i) 1))
0+1i
ok
lfe> (format (pow (i) 2))
-1+0i
ok
lfe> (format (pow (i) 3))
0-1i
ok
lfe> (format (pow (i) 4))
1+0i
ok
```

Negative powers are supported:

```lisp
lfe> (pow (pi) -2)
#(complex 0.10132118364233778 0.0)
lfe> (pow (two) -4)
#(complex 0.0625 0.0)
```

As are fractional powers (roots):

```lisp
lfe> (pow 16 (/ 1 2))
#(complex 4.0 0)
lfe> (pow 16 (/ 1 4))
#(complex 2.0 0)
lfe> (pow 16 (/ 1 8))
#(complex 1.4142135623730951 0)
```

See the [unit tests](tests) for a greater number of examples.

## API [&#x219F;](#table-of-contents)

The list of functions currently supported by the complex library are as follows:

```lisp
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

## License [&#x219F;](#table-of-contents)

Apache Version 2 License

Copyright © 2015-2020, Duncan McGreggor <oubiwann@gmail.com>

<!-- Named page links below: /-->

[logo]: priv/images/complex-function-crop-x250.png
[logo-large]: priv/images/complex-function-crop-x1000.png
[org]: https://github.com/lfex
[github]: https://github.com/lfex/complex
[gitlab]: https://gitlab.com/lfex/complex
[travis]: https://travis-ci.org/lfex/complex
[travis badge]: https://img.shields.io/travis/lfex/complex.svg
[lfe]: https://github.com/rvirding/lfe
[lfe badge]: https://img.shields.io/badge/lfe-1.3.0-blue.svg
[erlang badge]: https://img.shields.io/badge/erlang-19%20to%2023-blue.svg
[versions]: https://github.com/lfex/complex/blob/master/.travis.yml
[github tags]: https://github.com/lfex/complex/tags
[github tags badge]: https://img.shields.io/github/tag/lfex/complex.svg
[github downloads]: https://img.shields.io/github/downloads/lfex/complex/total.svg
[hex badge]: https://img.shields.io/hexpm/v/complex_math.svg?maxAge=2592000
[hex package]: https://hex.pm/packages/complex_math
[hex downloads]: https://img.shields.io/hexpm/dt/complex_math.svg
