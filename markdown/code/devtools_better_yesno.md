A more sane "yesno" for devtools
# A More Sane `yesno` for **devtools**

When working with [**devtools**](https://devtools.r-lib.org/), you'll often be
asked a yes/no question and get the annoying prompt of three randomly ordered
and randomly worded variations of "Yes" and "No", so that you have to think hard
to pick the right one. I get what they're trying to do (force you to actually
think about the question rather than hitting "Y" repeatedly) but I find it very
annoying. Here's a fix.

Add this code to your .Rprofile, and you'll now get a static 1: Yes, 2: No
prompt.

<script src="https://gist.github.com/josherrickson/17c9edbd5d4f820d65455ba4ff46e6d0.js"></script>
