XMonad Setup
# XMonad Setup

Install `XMonad`, `XMobar`, `dmenu` and `trayer` on your system. There are alternatives to some of these, but I've found each of them to be
lightweight & stable.

Get the following files from my [dotfiles repository](https://www.github.com/josherrickson/dotfiles) and put them inside `~/.xmonad`.

-   **xmonad.hs**, this contains settings specific to XMonad tiling, and launches XMobar.
-   **xmobar.rc**, this contains the layout for XMobar (Note: the syntax for this file doesn't allow comments, so check [the official FAQ](http://projects.haskell.org/xmobar) for configuration details).
-   **xmonad-init**, this will be executed on startup of XMonad, and can contain any auxilary programs you want to run, especially trayer. It must contain the line `exec xmonad`. It also needs to be executable (`chmod +x xmonad-init`).

Finally, find the file `/usr/share/xsessions/xmonad.desktop`. The line beginning with `Exec` must be

          Exec=/path/to/xmonad-init

Now, when logging in, choose the xmonad option.
