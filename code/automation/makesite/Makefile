# START:build
# START:vars
PAGES = pages
OUTPUT = output
# END:vars

# START_HIGHLIGHT
SOURCE_FILES = $(wildcard $(PAGES)/*.html)
DEST_FILES = $(patsubst $(PAGES)/%.html, $(OUTPUT)/%.html, $(SOURCE_FILES))

build: $(DEST_FILES)
# END_HIGHLIGHT
# END:build
# START:convert

# START:replace
$(OUTPUT)/%.html : $(PAGES)/%.html
	@echo "Creating $@ from $<"
	@mkdir -p $(dir $@)
	@cat template/header.html $< template/footer.html > $@.tmp
# END:convert
# START_HIGHLIGHT
	@sed s/@DATE@/"$(shell date "+%B %d, %Y")"/ $@.tmp > $@
	@rm $@.tmp
# END_HIGHLIGHT
# END:replace

# START:clean
clean:
	@rm -rf $(OUTPUT)
# END:clean

