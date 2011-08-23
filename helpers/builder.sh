
JSLINTR_BIN=$1

function remove_old () {
	if [ -f "$JSLINTR_BIN" ]; then
		rm -f "$JSLINTR_BIN"
	fi
}

function build_new () {
	touch $JSLINTR_BIN
	chmod u+w $JSLINTR_BIN

	cat "src/exports.sh" > $JSLINTR_BIN
	cat "src/core.sh" >> $JSLINTR_BIN
	cat "src/call_jslintr.sh" >> $JSLINTR_BIN
	cat "src/main.sh" >> $JSLINTR_BIN

	chmod u+x $JSLINTR_BIN
}

echo "\n- Building to $JSLINTR_BIN" && \
remove_old && \
build_new && \
echo "- Build OK"