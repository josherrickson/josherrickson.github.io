Statistics Notes
# Statistics Notes

[Marginal Effects](marginsnotes/index.html): A long-form document on using marginal effects (marginal means and marginal slopes) to improve interpretation of regression coefficients, especially in the presence of an interaction. Presents as a rosetta stone for Stata's `margins` command and R. *Software*: Stata and R.

[Interpreting log transformations in regression](stats-notes/logtransform.html): Interpreting coefficients from a linear regression model (or linear mixed model) when the predictor and/or the outcome have been log transformed. *Software*: R, though concepts could transfer to other software.

[Random intercepts in SPSS's Mixed Model](stats-notes/mixedModelsSPSS.html): There are two ways of specifying random intercepts in SPSS's Mixed Model; this discusses their equivalence. *Software*: SPSS.

[Moderation and Mediation via Regression](stats-notes/moderationMediation.html): Although moderation and mediation typically arise in SEM/path analysis frameworks, moderation can be addressed in regression, and mediation can be conceptualized through regression.

[IRR and ICC](stats-notes/iccirr.html): Some notes on IRR versus ICC, as well as how to obtain the ICC. *Software*: R, though concepts could transfer to other software.

[The issue of collinear predictors](stats-notes/visualizeCollinearity.html): A visualization to see the potential negative effect of including highly collinear variables in a model. *Software*: R, though concepts could transfer to other software.

[Interpreting regression coefficients of different models](stats-notes/regressioncoefs.html): Very sparse notes on interpreting coefficients in linear, logistic, Poisson and negative binomial regression models.

[Stata, `xt` versus mixed model](stats-notes/xtsetvsmixed.html): Econometricians usually use the `xt` framework to address repeated measures. This document shows how to fit the equivalent of fixed effects regression, between effects regression, and random effects regression using linear regression (`regress`) and linear mixed models (`mixed`). *Software*: Stata.

[Nested versus crossed random effects](stats-notes/vizrandomeffects.html): Multiple random effects in a mixed model are typically defined as either "nested" or "crossed". This document shows that this is a false dichotomy (nested random effects aren't real!), as well as showing some nice visualization. *Software*: R, though concepts could transfer to other software.

[Linear splines versus interactions](stats-notes/splinesvsinteraction.html): Models such as interrupted time series or diff-in-diff are often considered special analyses. This document attempts to show that these are just regression models with particular interactions. *Software*: Stata, though concepts could transfer to other software.

[Selecting a random subset of the data, potentially within subgroups](stats-notes/randomselection.html): An easy way to generate a random sample of your data of arbitrary size, including a stratified approach. *Software*: Stata, though concepts could transfer to other software.

[Mediation with Survey data](stats-notes/svy_gsem_teffects.html): To fit a mediation model in Stata using complex survey data requires using `gsem`. Unfortunately, the `gsem` command does not support directly estimating direct, indirect and total effects. This documents how to compute them. *Software*: Stata.

[The "Divide by 4" rule](stats-notes/divideby4.html): An additional tool in interpretiing logistic regression coefficients is the "Divide by 4" rule. *Software*: Stata, though concepts could transfer to other software.
