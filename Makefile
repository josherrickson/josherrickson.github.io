.PHONY:default
default: index.html code.html stats-notes.html workshops.html

%.html: %.md style.css
	@echo "$< -> $@"
	@awk -v newTitle="$(shell head -1 $<)" '{gsub("--title--",newTitle); print}' header.html > header_tmp.html
	@sed '1d' $< > tmp.md
	@pandoc -o tmp.html tmp.md
	@cat header_tmp.html tmp.html > $@
	@/bin/rm tmp.html header_tmp.html tmp.md
	@echo "</body>" >> $@
	@echo "</html>" >> $@

.PHONY:open
open:
	@open index.html
