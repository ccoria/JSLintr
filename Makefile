export JSLINTR_ROOT=${JSLINTR_ROOT:-$(pwd -P)}
export JSLINTR_SRC="${JSLINTR_ROOT}/src/"

export JSLINTR_BIN="${JSLINTR_ROOT}/bin/jslintr"
export JSLINTR_TMP="/tmp/jslintr"

.PHONY: build
build:
	@echo "Building to $(JSLINTR_BIN)"
	@helpers/builder.sh $(JSLINTR_BIN)
	@echo "Build OK"
	
.PHONY: tests
tests: JSLINTR_BIN=$(JSLINTR_TMP)
tests: build
tests:
	@echo "\n\n- Starting Tests\n"
	@tests/test