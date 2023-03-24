---
title: "Exclude files from git commands"
date: 2023-03-22T12:59:53-04:00
tags:
  - git
  - terminal
---

To exclude files from git commands such as `git grep` or `git diff`:

```bash
git grep foobar -- ':!*.java'
git diff -- ':!*.html' ':!abc.csv'
```

Works for whole folders as well.
