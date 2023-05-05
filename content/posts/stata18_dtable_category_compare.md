---
title: "Category-wise comparisons in Stata 18's `dtable`"
date: 2023-05-04T20:29:55-04:00
tags:
  - Stata
---

Stata 18's new [`dtable`](https://www.stata.com/manuals/rdtable.pdf) is terrific
for creating a "Table 1", but by default if provided a categorical variable and
asked to test for differences by group, it will provide a single Chi-sq test by
default.

```stata
. sysuse auto, clear
(1978 automobile data)

. dtable i.rep78, by(foreign, tests)
note: using test pearson across levels of foreign for rep78.

-----------------------------------------------------------
                                  Car origin
                    Domestic    Foreign     Total     Test
-----------------------------------------------------------
N                  52 (70.3%) 22 (29.7%) 74 (100.0%)
Repair record 1978
  1                  2 (4.2%)   0 (0.0%)    2 (2.9%) <0.001
  2                 8 (16.7%)   0 (0.0%)   8 (11.6%)
  3                27 (56.2%)  3 (14.3%)  30 (43.5%)
  4                 9 (18.8%)  9 (42.9%)  18 (26.1%)
  5                  2 (4.2%)  9 (42.9%)  11 (15.9%)
-----------------------------------------------------------
```

Instead you may want a category-by-category comparison of proportions. We'll
need to create a series of binary variables first.

```stata
. quietly tab rep78, gen(repcat)

. label var repcat1 "Repair Record Category 1"

. label var repcat2 "Repair Record Category 2"

. label var repcat3 "Repair Record Category 3"

. label var repcat4 "Repair Record Category 4"

. label var repcat5 "Repair Record Category 5"
```

Next, we can add each of the `repcat*` to `dtable`, but preface with `1.` to
only include the "yes" for each binary.

```stata

. dtable 1.repcat*, by(foreign, tests)
note: using test pearson across levels of foreign for repcat1, repcat2, repcat3, repcat4, and repcat5.

-----------------------------------------------------------------
                                        Car origin
                          Domestic    Foreign     Total     Test
-----------------------------------------------------------------
N                        52 (70.3%) 22 (29.7%) 74 (100.0%)
Repair Record Category 1
  1                        2 (4.2%)   0 (0.0%)    2 (2.9%)  0.342
Repair Record Category 2
  1                       8 (16.7%)   0 (0.0%)   8 (11.6%)  0.047
Repair Record Category 3
  1                      27 (56.2%)  3 (14.3%)  30 (43.5%)  0.001
Repair Record Category 4
  1                       9 (18.8%)  9 (42.9%)  18 (26.1%)  0.036
Repair Record Category 5
  1                        2 (4.2%)  9 (42.9%)  11 (15.9%) <0.001
-----------------------------------------------------------------
```

So we have the tests we want (at least, if you're OK with a Chi-sq test for each
binary against the group variable), but the extra "1" entries is redundant. We
can use [`collect`](https://www.stata.com/manuals/tablescollectstyleheader.pdf)
to modify this.

```stata
. collect style header repcat1 repcat2 repcat3 repcat4 repcat5, level(hide)

. collect preview

-----------------------------------------------------------------
                                        Car origin
                          Domestic    Foreign     Total     Test
-----------------------------------------------------------------
N                        52 (70.3%) 22 (29.7%) 74 (100.0%)
Repair Record Category 1   2 (4.2%)   0 (0.0%)    2 (2.9%)  0.342
Repair Record Category 2  8 (16.7%)   0 (0.0%)   8 (11.6%)  0.047
Repair Record Category 3 27 (56.2%)  3 (14.3%)  30 (43.5%)  0.001
Repair Record Category 4  9 (18.8%)  9 (42.9%)  18 (26.1%)  0.036
Repair Record Category 5   2 (4.2%)  9 (42.9%)  11 (15.9%) <0.001
-----------------------------------------------------------------
```
