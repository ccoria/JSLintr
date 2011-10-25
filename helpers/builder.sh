
BUILDER_TARGET=$1
JSLINTR_LIBS=$2
JSLINTR_OPTIONS_FILE=$3

JSLINTR_BIN=$BUILDER_TARGET/jslintr

LIB_FILES_TARGET=$BUILDER_TARGET/lib/
OPTIONS_FILE_TARGET=$BUILDER_TARGET/options

function bootstrap () {
	#echo " . verifying if directory exists and if has files"
	if [ -s $BUILDER_TARGET ]; then
		echo "- Removing all files of target directory: $BUILDER_TARGET"
		rm -rf $BUILDER_TARGET/*
	else
		echo "- No files to delete on target"
	fi
	
	mkdir -p $LIB_FILES_TARGET
}

function build_new () {
	#echo " . assembling new jslintr"
	
	touch $JSLINTR_BIN
	chmod u+w $JSLINTR_BIN
	
	# exports
	# It has to be here because it depends on which is the builder target directory 
	echo "export JSLINTR_ROOT=$BUILDER_TARGET/" > $JSLINTR_BIN
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
	
	#echo "copying all lib files ($JSLINTR_LIBS) to bin/libs dir: $LIB_FILES_TARGET"
	cp -R $JSLINTR_LIBS $LIB_FILES_TARGET
	
	#echo "copying the config file ($JSLINTR_OPTIONS_FILE) to bin dir ($OPTIONS_FILE_TARGET)"
	cp $JSLINTR_OPTIONS_FILE $OPTIONS_FILE_TARGET
}

if [ -z $1 ];then
	echo "You should define a valid target"
elif [ -z $2 ];then
	echo "You should define a valid libs source dir"
elif [ -z $3 ];then
	echo "You should define a valid options source file"
else
	echo "\n- Building to $JSLINTR_BIN" && \
	bootstrap && \
	copy_required_files && \
	build_new && \
	echo "- Build OK"
fi