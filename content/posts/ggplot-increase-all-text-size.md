---
title: "Increase ALL Text Size in ggplot"
date: 2023-03-22T12:04:41-04:00
tags:
  - R
  - ggplot
  - visualization
---

You can add

```r
+ theme(text = element_text(size=20))
```

to a `ggplot` object to modify the size of ALL text elements.

(This is with `ggplot` 3.4.1 in case they change the API again.)
