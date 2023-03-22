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
	@open docs/index.html

.PHONY:clean
clean:
	@/bin/rm -f $(PRIMARY_HTML)

.PHONY:fresh
fresh: clean all

# Note that below, `open` occurs before the server is started. This is because
# the `open` would never be called if it happened afterwards. As soon as the
# server starts, the `open` will resolve, so reload if needed
.PHONY:preview
preview:
	@open http://localhost:1313
	@hugo server -D -d docs

.PHONY:preview-no-drafts
preview-no-drafts:
	@open http://localhost:1313
	@hugo server -d docs


.PHONY:new-post
new-post:
ifdef title
	@hugo new posts/$(title).md
	@emacs content/posts/$(title).md
else
	@echo "pass \`title=mytitle\` to create new post"
endif
