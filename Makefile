.PHONY:default
default:
	@R -q -e "rmarkdown::render_site()"

.PHONY:open
open:
	@open index.html
