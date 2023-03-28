---
title: "Expect_silent and Debugging"
date: 2023-03-28T09:27:03-04:00
---

When using the [`testthat`](https://testthat.r-lib.org/) package, there is a
function,
[`expect_silent()`](https://testthat.r-lib.org/reference/expect_silent.html), to
ensure no notes, warnings, or errors get produced.

If you are trying to debug this call (either via explicit
[`debug()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/debug.html)
or inserting a call to
[`browser()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/browser.html)),
the `expect_silent()` will suppress all output. Remove the `expect_silent()`
call to properly debug!
