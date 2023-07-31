---
title: "Making a bibliography fit on one page in Beamer through Quarto"
date: 2023-07-31T11:54:18-04:00
---

When using [Quarto](https://quarto.org/docs/get-started/hello/rstudio.html), you
can add a bibliography with something like

```
### References

::: {#refs}
:::
```

https://quarto.org/docs/authoring/footnotes-and-citations.html#bibliography-generation

However, if producing slides via
[Beamer](https://quarto.org/docs/presentations/beamer.html), the number of
references can cause the text to run off the slide. You can use the `shrink`
option to automatically reduce the font size to fit everything, or the
`allowframebreaks` option to split the bibliography onto multiple pages.


```
### References {shrink=5}

::: {#refs}
:::
```

The numeric argument of `shrink` is the minimum shrink size - making it too high
can yield strange results, so start with it small and increase if necessary.

```
### References {allowframebreaks=.9}

::: {#refs}
:::
```

The numeric argument of `allowframebreaks` controls how much of a given frame is
allow to be filled. E.g. a value of "1" would use every inch of the slide - very
cluttered.
