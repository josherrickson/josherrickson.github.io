---
title: "Character-wise String Comparison in R"
date: 2023-03-29T06:05:44-04:00
tags:
  - R
---

If you have two strings in R and want to check character-by-character equality:

```r
a <- "abcdef"
b <- "abcdff"
Reduce(`==`, strsplit(c(a, b), ""))
```

This results in:

```r
> Reduce(`==`, strsplit(c(a, b), ""))
[1]  TRUE  TRUE  TRUE  TRUE FALSE  TRUE
```
