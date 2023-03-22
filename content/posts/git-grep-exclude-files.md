---
title: "Exclude files from git grep"
date: 2023-03-22T12:59:53-04:00
tags:
  - git
---

To exclude files from `git grep`:

```bash
git grep foobar -- ':!*.java'
git grep foobar -- ':!*.html' ':!abc.csv'
```
