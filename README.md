# complex

*LFE support for numbers both real and imagined*

<img src="resources/images/complex-function-crop-x250.png" />

## Introduction

This library provides a data type (LFE record) for complex numbers as well as
many mathematical operations which support the complex data type. For a full
list of functions in the API, see the bottom of this README file.


## Installation

Just add it to your ``rebar.config`` deps:

```erlang
  {deps, [
    ...
    {complex, ".*",
      {git, "git@github.com:YOURNAME/complex.git", "master"}}
      ]}.
```

And then do the usual:

```bash
    $ rebar get-deps
    $ rebar compile
```


## Usage

Add content to me here!

## API

The list of functions supported by the complex library are as follows:

```cl
complex:new/0
complex:new/1
complex:new/2
complex:add/2
complex:div/2
complex:mult/2
complex:sub/2
complex:abs/1
complex:conj/1
complex:eq/2
complex:inv/1
complex:modulus/1
complex:neg/1
complex:sign/1
complex:sqrt/1
complex:print/1
complex:->str/1
complex:->str/3
```
