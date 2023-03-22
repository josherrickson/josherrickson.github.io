---
title: "Subsets and subpopulations in complex survey designs"
date: 2023-03-22T13:20:56-04:00
tags:
  - statistics
---

Generally you should **not** just subset complex survey data to do subpopulation
analysis, instead using the built in tools, e.g. Stata's [`svy, subpop(z):
...`](https://www.stata.com/manuals/svysubpopulationestimation.pdf) or R's
[`subset.survey.design`](https://www.rdocumentation.org/packages/survey/versions/4.1-1/topics/subset.survey.design)

However, in the following two scenarios, subsetting versus formal subpopulations will give identical results:

1. The subpopulation are strata. For example, say you stratify by race where
   race can take on categories "white", "black" and "other.. If you want to look
   at one race ("black") (or several races ["black" and "other"]), these
   subpopulations capture one (or several) entire strata.
2. Every cluster has at least one member of the subpopulation.

Source: https://notstatschat.rbind.io/2021/07/22/subsets-and-subpopulations-in-survey-inference/
