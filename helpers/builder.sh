
JSLINTR_BIN=$1
JSLINTR_LIBS=$2
JSLINTR_OPTIONS_FILE=$3

JSLINTR_BIN_DIR=$(dirname $JSLINTR_BIN)

LIB_FILES_TARGET=$JSLINTR_BIN_DIR/lib/
OPTIONS_FILE_TARGET=$JSLINTR_BIN_DIR/options

function remove_old () {
	# verifying if directory exists and if has files
	if [ -s $JSLINTR_BIN_DIR ]; then
		rm -f $JSLINTR_BIN_DIR/*
	else
		echo "no files"
	fi
}

function build_new () {
	touch $JSLINTR_BIN
	chmod u+w $JSLINTR_BIN
	
	#exports
	echo "export JSLINTR_ROOT=$JSLINTR_BIN_DIR/" > $JSLINTR_BIN
	echo "export JSLINTR_LIB=$LIB_FILES_TARGET" >> $JSLINTR_BIN
	echo "export BIN_OPTIONS_FILE=$OPTIONS_FILE_TARGET" >> $JSLINTR_BIN
	
	# assembling files
	cat "src/exports.sh" >> $JSLINTR_BIN
	cat "src/core.sh" >> $JSLINTR_BIN
	cat "src/call_jslintr.sh" >> $JSLINTR_BIN
	cat "src/main.sh" >> $JSLINTR_BIN

	chmod u+x $JSLINTR_BIN
}

function copy_required_files () {
	
	# copying all lib files to bin dir
	cp -R $JSLINTR_LIBS $LIB_FILES_TARGET
	
	# copying the config file to bin dir
	cp $JSLINTR_OPTIONS_FILE $OPTIONS_FILE_TARGET
}

echo "\n- Building to $JSLINTR_BIN" && \
remove_old && \
copy_required_files && \
build_new && \
echo "- Build OK"