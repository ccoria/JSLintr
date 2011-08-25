export JSLINTR_ROOT=$(shell pwd -P)
export JSLINTR_SRC=$(JSLINTR_ROOT)/src/

export JSLINTR_BIN=$(JSLINTR_ROOT)/bin/jslintr
export JSLINTR_TMP="/tmp/jslintr"

.PHONY: build
build:
	@helpers/builder.sh $(JSLINTR_BIN)
	
.PHONY: tests
tests: JSLINTR_BIN=$(JSLINTR_TMP)
tests: build
tests:
	@echo "\n- Starting Tests\n"
	@tests/test