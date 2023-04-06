---
title: "R's `all.equal`, relative vs absolute"
date: 2023-04-06T10:29:25-04:00
tags:
  - R
---

The
[`all.equal()`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/all.equal)
function is useful to comparing whether two numeric objects are equivalent, but
it has a weird quirk.

```r
> all.equal(4, 5)
[1] "Mean relative difference: 0.25"
```

You might expect that the difference should be 1. But note the "relative
difference." The default for `all.equal` is to report the difference for a call
of `all.equal(x, y)` as |x - y|/x. This also means that `all.equal(x, y)` is not
going to report the same difference as `all.equal(y, x)`.


The `scale=` argument makes `all.equal` instead report absolute difference:

```r
> all.equal(4, 5, scale = 1)
[1] "Mean absolute difference: 1"
```

This comes in especially with the `tolerance=` argument. Let's say you want to
consider two values "equal" if they're less than .5 apart.

```r
> all.equal(4, 4.4, tolerance = .5)
[1] TRUE
> all.equal(4, 5, tolerance = .5)
[1] TRUE
```

That second one is clearly wrong. However, if we set the `scale=` argument to 1,
the tolerance is applied on the absolute scale instead.

```r
> all.equal(4, 5, tolerance = .5, scale = 1)
[1] "Mean absolute difference: 1"
```
