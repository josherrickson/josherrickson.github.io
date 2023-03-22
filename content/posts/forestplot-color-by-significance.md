---
title: "Color by Significance in R's `forestplot`"
date: 2023-03-22T12:44:42-04:00
tags:
  - R
  - visualization
  - forestplot
---

The
[forestplot](https://cran.r-project.org/web/packages/forestplot/vignettes/forestplot.html)
package doesn't easily support advanced coloring of each point, specifically to
flag significance levels.

It does however supported custom coloring via a moderately complicated custom
function, so here's an example of how to color by significance.

First, create the following function:

```r
fn <- local({
  i <- 0
  clrs <- ifelse(dat$pv < .05, "darkgreen",
                 -ifelse(dat$pv < .1, "blue", "darkgrey"))

  function(..., clr.line, clr.marker) {
    i <<- i + 1
    fpDrawNormalCI(...,
                   clr.line = clrs[i],
                   clr.marker = clrs[i])
  }
})
```

Inside `local()` so that `i` isn't manipulated elsewhere.

The `clrs` object defined in lines 3-4 returns a specific color based upon the
p-value, here stored in `dat$pv`. For context, "darkgreen" is used for p-values
below .05, "blue" for p-values below .10 (but above .05), and "darkgrey" for
p-values above .10.

If you want different colors for the points and the lines, define two different
vectors similar to `clrs`, and change lines 9-10 to point to the differing
vectors.

Following the creation of `fn`, you can add it to your `forestplot()` via:

```r
  forestplot(...,
             fn.ci_norm = fn,
             ...)
```
