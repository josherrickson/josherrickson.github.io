Making RStudio respect the PATH on OS X
# Making RStudio respect the \$PATH on OS X

RStudio does not respect the \$PATH environment variable on OS X.  However, it will respect a .Renviron file in your home directory. If you run the
following:

    echo PATH=$PATH > ~/.Renviron

then RStudio will source this file when opening.

You will have to re-run the command if you update your \$PATH.

You can check if this is working by running

    system("echo $PATH")

Reference:
<http://stackoverflow.com/questions/31121645/rstudio-shows-a-different-path-variable>
