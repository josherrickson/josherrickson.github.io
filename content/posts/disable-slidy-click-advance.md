---
title: "Disable Slidy Click Advance"
date: 2023-03-22T13:30:35-04:00
tags:
  - R
  - Rmarkdown
---

[Slidy
presentations](https://bookdown.org/yihui/rmarkdown/slidy-presentation.html) in
R, by default, advance on mouse-click, which can be frustrating.

Once you have a Slidy presentation loaded, the "k" key will disable this.

We can disable it more generally by modifying the `rmarkdown` package you have
installed.

1. Find your `rmarkdown` installation:

```r
system.file(package = "rmarkdown")
```

2. Navigate to that directory, then edit the file:

```
rmd/slidy/Slidy2/scripts/slidy.js
```

3. Find the line that defines `mouse_click_enabled` (in `rmarkdown` version
   2.20, this is line 55). Change the value of `true` to `false`.
