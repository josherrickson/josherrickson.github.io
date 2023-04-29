---
title: "R's sys.call vs match.call"
date: 2023-04-29T10:17:10-04:00
tags:
  - R
---

The `sys.call()` function returns the exact call to the function.

The `match.call()` function names all arguments and orders them as appropriate.

```r
f <- function(x, y = 2) {
  print(paste("sys.call():", deparse(sys.call())))
  print(paste("match.call():", deparse(match.call())))
  invisible(TRUE)
}
```

This results in:

```r
> f(1, 2)
[1] "sys.call(): f(1, 2)"
[1] "match.call(): f(x = 1, y = 2)"
> f(y = 2, x = 1)
[1] "sys.call(): f(y = 2, x = 1)"
[1] "match.call(): f(x = 1, y = 2)"
> f(6)
[1] "sys.call(): f(6)"
[1] "match.call(): f(x = 6)"
```

Note the last example does not include a `y = 2` argument.
