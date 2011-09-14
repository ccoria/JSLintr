export JSLINTR_ROOT=$(shell pwd -P)
export JSLINTR_SRC=$(JSLINTR_ROOT)/src/
export JSLINTR_BIN=$(JSLINTR_ROOT)/bin/jslintr
export JSLINTR_LIBS=$(JSLINTR_ROOT)/libs/
export JSLINTR_TMP_DIR=/tmp/_jslintr/
export JSLINTR_TMP=$(JSLINTR_TMP_DIR)/jslintr

export OPTIONS_FILE=$(JSLINTR_ROOT)/etc/options.sample

export DEFAULT_TARGET=$(JSLINTR_ROOT)/bin

run_builder:
	@helpers/builder.sh "$(TARGET)" "$(JSLINTR_LIBS)" "$(OPTIONS_FILE)"

.PHONY: build
build: TARGET=$(DEFAULT_TARGET)
build: run_builder

.PHONY: create_tmp
create_tmp:
	@rm -rf $(JSLINTR_TMP_DIR)
	@mkdir $(JSLINTR_TMP_DIR)

.PHONY: tests
tests: TARGET=$(JSLINTR_TMP_DIR)
tests: create_tmp run_builder
tests:
	@echo "- Starting Tests\n"
	@tests/test
	@rm -rf $(JSLINTR_TMP_DIR)