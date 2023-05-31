---
title: "Move N= in Stata 18's `dtable`"
date: 2023-05-31T09:46:01-04:00
tags:
  - Stata
---

By default, the [`dtable`](https://www.stata.com/manuals/rdtable.pdf) command
places the sample size in its own row:

```stata
. sysuse auto, clear
(1978 automobile data)

. dtable mpg, by(foreign)

----------------------------------------------------------
                               Car origin
                 Domestic        Foreign         Total
----------------------------------------------------------
N                 52 (70.3%)     22 (29.7%)    74 (100.0%)
Mileage (mpg) 19.827 (4.743) 24.773 (6.611) 21.297 (5.786)
----------------------------------------------------------
```

We can use the following two additional options to relocate it:

```stata

. dtable mpg, by(foreign) ///
>             sample(, statistics(freq) place(seplabels)) ///
>             sformat("(N=%s)" frequency)

----------------------------------------------------------
                               Car origin
                 Domestic        Foreign         Total
                  (N=52)         (N=22)         (N=74)
----------------------------------------------------------
Mileage (mpg) 19.827 (4.743) 24.773 (6.611) 21.297 (5.786)
----------------------------------------------------------
```

The `sample()` option chooses which sample-level characteristics to report with
`statistics(freq)`, and the `place()` suboption choses their location:

- `place(items)` is the default.
- `place(inlabels)` places it in the column headers (e.g. we'd see "Domestic (N=52)").
- `place(seplabels)` places it below the column headers.

The `sformat()` option formats a particular type of reported results (in this
case, "`frequency`") with a given string.
