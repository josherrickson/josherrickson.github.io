PRIMARY_MD=$(shell find . -d 1 -name "*.md")
PRIMARY_HTML=$(PRIMARY_MD:.md=.html)

CODE_MD=$(shell find code -name "*.md")
CODE_HTML=$(CODE_MD:.md=.html)

.PHONY:all
all: $(PRIMARY_HTML) $(CODE_HTML)

# Defines type of navigation links on bottom of page.
# none: No links (only for index)
# home: Link to index; only for files in top directory that aren't index
# code: link to index, or main code page, for files in code directory
$(CODE_HTML): LINK:=code
$(PRIMARY_HTML): LINK:=home
index.html: LINK:=none


%.html: %.md header.html
	@echo "$< -> $@"
	@awk -v newTitle="$(shell head -1 $<)" '{gsub("--title--",newTitle); print}' header.html > header_tmp.html
	@sed '1d' $< > tmp.md
	@pandoc -o tmp.html tmp.md
	@cat header_tmp.html tmp.html > $@
	@/bin/rm tmp.html header_tmp.html tmp.md
# Add appropriate navigation links based on $(LINK)
	@if [ $(LINK) == home ]; then echo "<a href='index.html'>Home</a>" >> $@; fi;
	@if [ $(LINK) == code ]; then echo "<a href='../index.html'>Home</a> | <a href='../code.html'>Back to Misc Code & Software</a>" >> $@; fi;
	@echo "</body>" >> $@
	@echo "</html>" >> $@

.PHONY:open
open:
	@open index.html

.PHONY:clean
clean:
	@/bin/rm -f $(PRIMARY_HTML) $(CODE_HTML)
