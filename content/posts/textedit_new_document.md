---
title: "Making TextEdit start with a Blank Document"
date: 2023-06-01T14:19:07-04:00
---

It used to be that launching OSX's TextEdit would open a blank document for
immediate typing/pasting. At some point over the last several years, it changed
to show a file picked by default.

To switch to the older functionality, run the following terminal command:

```
defaults write com.apple.TextEdit NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false
```

Source:  https://apple.stackexchange.com/a/111755
