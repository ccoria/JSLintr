export JSLINTR_ROOT=$(shell pwd -P)
export JSLINTR_SRC=$(JSLINTR_ROOT)/src/

export JSLINTR_BIN=$(JSLINTR_ROOT)/bin/jslintr
export JSLINTR_LIBS=$(JSLINTR_ROOT)/libs/

export JSLINTR_TMP_DIR=/tmp/_jslintr/
export JSLINTR_TMP=$(JSLINTR_TMP_DIR)/jslintr

export OPTIONS_FILE=$(JSLINTR_ROOT)/etc/options.sample

.PHONY: build
build:
	@helpers/builder.sh $(JSLINTR_BIN) $(JSLINTR_LIBS) $(OPTIONS_FILE)

.PHONY: create_tmp
create_tmp:
	@rm -rf $(JSLINTR_TMP_DIR)
	@mkdir $(JSLINTR_TMP_DIR)

.PHONY: tests
tests: JSLINTR_BIN=$(JSLINTR_TMP)
tests: create_tmp build
tests:
	@echo "- Starting Tests\n"
	@tests/test
	@rm -rf $(JSLINTR_TMP_DIR)