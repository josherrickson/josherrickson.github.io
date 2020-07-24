Creating Variants of a File with R + Knitr + Brew + LaTeX
# Creating Variants of a File with R + Knitr + Brew + LaTeX

The concept for this is based upon [http://botthoughts.wordpress.com/2012/05/17/generating-reports-for-different-data-sets-using-brew-and-knitr/](http://botthoughts.wordpress.com/2012/05/17/generating-reports-for-different-data-sets-using-brew-and-knitr/).

I had the need to create personalized exams for students - There were three sets of size seven, three and one respectively, of which each student essentially received one randomly. This setup could be useful in other settings involving the need for multiple files based on a template, and some variable.

First, you need in R some way to differentiate the variants. A data frame where each row is a variant works perfectly. Considering the following example

    > data
          X1   X2
    1  Alice ver1
    2    Bob ver2

Here, `X1` is a name I want to include in the output, and `X2` refers to some larger change I want to make. In my personalized exam setup, that was two different questions.

The R code to handle this is as follows.

    library(brew)
    library(tools)
    library(knitr)

    genReports <- function(x, prepend) {
      rnw.file <- paste0(prepend, x[1], ".Rnw")
      brew("template.Rnw", rnw.file)
      knit(rnw.file)
      latex.file <- paste0(prepend, x[1], ".tex")
      texi2pdf(latex.file, clean = TRUE, quiet = TRUE)
      out.file <- paste0(prepend, x[1], ".pdf")
      return(out.file)
    }

    apply(data, 1, genReports, prepend="report_")

`brew` and `knit`  handle replacing any R code, and then `texi2pdf` generates the actual PDF.

That code references a template.Rnw file. That can be just a regular LaTeX file, with a small change. A minimal example is below.

    \documentclass{article}
    \begin{document}
    Name: <%= x[1] %>

    \input{<%= x[2] %>
    \end{document}

(Note that you can also put Knitr code, which is similar to Sweave, directly in the file to run R code. For example, you could add

    <<printingchunk>>=
    plot(rnorm(100))
    @

which would be replaced with that plot in the PDF.)

 The `<%= x[1] %>` notation is what does the magic - that will be replaced by `brew` + `knit`. Using the `\input` command allows means that ver1.tex and ver2.tex have to exist, but they should be LaTeX chunks, not a complete file (e.g. no header.)

So our end result, assuming we have ver1.tex and ver2.tex as two different questions, is that we have two PDF files, named report_Alice.pdf and report_Bob.pdf, where both have the individuals' names in the first line, and then contain two different questions.

As an additional note, there are two easy ways to print a lot of these simultaneously. First, you could call something like

    for f in report_*.pdf; do lp  $f; done</pre>

and passing any additional arguments to `lp`. Secondly, the command `pdfunite` in the `poppler` package can be used to merge the files. (Just ensure that each file has an even number of pages if you plan to print double-sided, padding each file with a `\newpage` if needed.)
