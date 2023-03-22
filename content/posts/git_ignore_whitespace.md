---
title: "Ignore whitespace on Git diffs"
date: 2023-03-22T10:38:51-04:00
draft: false
tags:
  - git
  - github
---

By default, git's diff (`git diff` or on Github) show whitespace changes as well
as meaningful changes.

To suppress them in `git diff`, add the `-b` flag:

```
git diff -b
```

To suppress on github.com, append `?w=1` to any diff's URL.