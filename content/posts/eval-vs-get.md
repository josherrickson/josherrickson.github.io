---
title: "Eval vs Get"
date: 2023-03-27T10:14:52-04:00
tags:
  - R
---


I've been fighting damn scoping issues lately and finally sat down to figure out
what works and when. Documenting some of them here

The lessons I've learned from this:

1. `eval(a, envir = ... )` DOES NOT WORK!
2. Instead, do `eval(str2lang("a"), envir = ...)`
3. `eval.parent(a)` DOES NOT WORK!
4. `eval.parent(str2lang("a"))` works and SKIPS GENERIC!
6. `get("a", envir = ...)` seems to always work as expected

So to summarize, I think `get` is always a safer option than `eval`. In
addition, `get` is much faster:

```r
> f1 <- function() {
+ eval.parent(str2lang("a"))
+ }
> f2 <- function() {
+ get("a", envir = sys.frame(0))
+ }
> a <- 1
> microbenchmark:::microbenchmark(f1(), f2(), times = 10000)
Unit: nanoseconds
 expr  min   lq      mean median   uq     max neval
 f1() 1353 1558 1854.5325   1640 1763 1019547 10000
 f2()  533  656  808.4462    697  738  800074 10000
```

Obviously this doesn't cover more advanced situations, like evaluating full
calls, but I'm still working on puzzling all that out.

Here's the sample code I used to evaluate this:

```r
foo <- function(x) {
  a <- "in generic"
  UseMethod("foo")
}

foo.numeric <- function(x) {
  a <- "in specific"
  print(sys.calls())

  # Itself
  print(paste("a:",
               a
              ))
  # Eval
  print(paste("eval(a):",
               eval(a)
        ))
  print(paste('eval(str2lang("a")):',
               eval(str2lang("a"))
        ))

  # eval.parent
  print(paste("eval.parent(a):",
               eval.parent(a)
              ))
  print(paste('eval.parent(str2lang("a")):',
               eval.parent(str2lang("a"))
              ))

  # eval with sys.frames
  print(paste("eval(a, envir = sys.frame(0)):",
               eval(a, envir = sys.frame(0))
              ))
  print(paste('eval(str2lang("a"), envir = sys.frame(0)):',
               eval(str2lang("a"), envir = sys.frame(0))
              ))
  print(paste("eval(a, envir = sys.frame(1)):",
               eval(a, envir = sys.frame(1))
              ))
  print(paste('eval(str2lang("a"), envir = sys.frame(1)):',
               eval(str2lang("a"), envir = sys.frame(1))
              ))

  # get
  print(paste('get("a"):',
               get("a")
              ))

  # get with sys.frames
  print(paste('get("a", envir = sys.frame(0)):',
               get("a", envir = sys.frame(0))
              ))
  print(paste('get("a", envir = sys.frame(1)):',
               get("a", envir = sys.frame(1))
              ))
}

a <- "in global"
foo(1)
```

This produces:

```r
[[1]]
foo(1)

[[2]]
UseMethod("foo")

[1] "a: in specific"
[1] "eval(a): in specific"
[1] "eval(str2lang(\"a\")): in specific"
[1] "eval.parent(a): in specific"
[1] "eval.parent(str2lang(\"a\")): in global"
[1] "eval(a, envir = sys.frame(0)): in specific"
[1] "eval(str2lang(\"a\"), envir = sys.frame(0)): in global"
[1] "eval(a, envir = sys.frame(1)): in specific"
[1] "eval(str2lang(\"a\"), envir = sys.frame(1)): in generic"
[1] "get(\"a\"): in specific"
[1] "get(\"a\", envir = sys.frame(0)): in global"
[1] "get(\"a\", envir = sys.frame(1)): in generic"
```
