PRIMARY_MD:=$(shell find markdown -name "*.md")
PRIMARY_HTML:=$(patsubst markdown/%.md,static/%.html,$(PRIMARY_MD))

.PHONY:all
all: static/pkgs.html $(PRIMARY_HTML)

markdown/pkgs.md: markdown/pkgs.Rmd
	@R -q -e 'rmarkdown::render(input = "$<", output_format = rmarkdown::md_document())'

static/%.html: markdown/%.md
	@echo "$< -> $@"
	@awk -v newTitle="$(shell head -1 $<)" '{gsub("--title--",newTitle); print}' markdown/header.html > markdown/header_tmp.html
	@sed '1d' $< > markdown/tmp.md
	@pandoc -o markdown/tmp.html markdown/tmp.md
	@cat markdown/header_tmp.html markdown/tmp.html > $@
	@/bin/rm markdown/tmp.html markdown/header_tmp.html markdown/tmp.md
# Add appropriate navigation links (Home for main pages, home/back to code for code pages)
	@if [ $(@D) == "static" ]; then echo "<a href='index.html'>Home</a>" >> $@; fi;
	@if [ $(@D) == "static/code" ]; then echo "<a href='../index.html'>Home</a> | <a href='../code.html'>Back to Misc Code & Software</a>" >> $@; fi;
	@echo "</body>" >> $@
	@echo "</html>" >> $@

.PHONY:open
open:
	@open index.html

.PHONY:clean
clean:
	@/bin/rm -f $(PRIMARY_HTML) $(CODE_HTML)

fresh: clean all
