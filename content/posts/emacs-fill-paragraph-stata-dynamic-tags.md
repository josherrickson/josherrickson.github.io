---
title: "Stopping `fill-paragraph` from breaking Stata inline dynamics tags"
date: 2023-08-22T05:56:45-04:00
tags:
  - emacs
  - stata
---

Stata inline dynamic tags contain spaces. E.g.
`<<dd_display: %9.3f abs(_b[2.rep78])>>`. This means that when using
[`fill-paragraph`](https://www.gnu.org/software/emacs/manual/html_node/emacs/Fill-Commands.html),
the inline tag can be broken, which Stata's
[`dyndoc`](https://www.stata.com/manuals/rptdyndoc.pdf) and
[`dyntext`](https://www.stata.com/manuals/rptdyntext.pdf) commands will break
on.

This snippet to include in your Emacs
[init](https://github.com/josherrickson/dotfiles/blob/main/init.el) file fixes
this issue.

```
(defun my-in-dd-display ()
  "Don't break lines in Inline Stata Dynamic Tags."
  (save-excursion
    (save-match-data
      (and (re-search-backward ">>\\|\\(<<dd_display:\\)"
                               (line-beginning-position) t)
       (match-beginning 1)))))
(add-hook 'fill-nobreak-predicate #'my-in-dd-display)
```

After defining the function with `defun`, the `add-hook` function is what
enables it's use with `fill-paragraph`. This comes from
<https://emacs.stackexchange.com/a/78562>
