MARKDOWN=markdown
SHOCCO=shocco

SCRIPTS=itemsForSc scsForSystem scsForUser itemsHistogram subjectForSc subjectsForUser
DOCS=$(wildcard *.md)
DOCS_BARE=$(basename $(DOCS))
IMGS:=SoftwareChangeList.jpg TACT_closure.gif BaselineItem.jpg BaselineItemList.jpg

PUBLIC_HTML=~spi/public_html/knowledgecity

SCRIPTS_REL_HTML=$(addsuffix .html,$(SCRIPTS))
SCRIPTS_HTML=$(addprefix $(PUBLIC_HTML)/, $(SCRIPTS_REL_HTML))
DOCS_REL_HTML:=$(addsuffix .html,$(DOCS_BARE))
DOCS_HTML=$(addprefix $(PUBLIC_HTML)/, $(DOCS_REL_HTML))
IMGS_HTML=$(addprefix $(PUBLIC_HTML)/, $(IMGS))

.SUFFIXES:
.SUFFIXES: .md .html
.md.html:
	$(MARKDOWN) < $< > $(PUBLIC_HTML)/$@

.PHONY : scripts_doc
scripts_doc:
	for s in $(SCRIPTS); \
	do \
	$(SHOCCO) $$s > $(PUBLIC_HTML)/$$s.html ;\
	done


.PHONY : imgs
imgs:
		cp $(IMGS) $(PUBLIC_HTML)


.PHONY : clean
clean:
	rm -f $(SCRIPTS_HTML) \
			$(DOCS_HTML) \
			$(IMGS_HTML)

.PHONY : doc
doc: scripts_doc imgs $(DOCS_REL_HTML)


.PHONY : make_exec
make_exec:
	chmod ug+x $(SCRIPTS)
