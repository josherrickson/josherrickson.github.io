---
title: "A More Sane `yesno()` for devtools"
date: 2023-03-22T13:45:59-04:00
tags:
  - R
  - devtools
---

When working with [**devtools**](https://devtools.r-lib.org/), you'll often be
asked a yes/no question and get the annoying prompt of three randomly ordered
and randomly worded variations of "Yes" and "No", so that you have to think hard
to pick the right one. I get what they're trying to do (force you to actually
think about the question rather than hitting "Y" repeatedly) but I find it very
annoying. Here's a fix.

Add this code to your .Rprofile, and you'll now get a static 1: Yes, 2: No
prompt.

```r
suppressMessages(require(devtools))
yesno <- function(...) {
  cat(paste0(..., collapse = ""))
  # For whatever reason, devtools:::yesno returns `TRUE` if you
  # select a No option, and `FALSE` if you select a Yes option
  utils::menu(c("Yes", "No")) != 1
}
utils::assignInNamespace("yesno", yesno, "devtools")
# remove stand-alone `yesno`
rm(yesno)
```
