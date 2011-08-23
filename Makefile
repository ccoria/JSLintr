
export JSLINTR_ROOT=${JSLINTR_ROOT:-$(pwd -P)}
export JSLINTR_SRC="$JSLINTR_ROOT/src/"

.PHONY: build
build: 
	@helpers/builder.sh "bin/jslintr"