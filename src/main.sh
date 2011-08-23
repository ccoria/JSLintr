
###
# Verifying usage and calling jslintr =)
#
function main () {
	
	###
	# Verifying optional parameters
	#
	case "$1" in 
		"-v" | "--verbose")		shift
								VERBOSE=1
								;;
		*)						VERBOSE=0
								;;
	esac
	
	local TARGET="${1}"
	local OPTIONS_FILE="${2}"
	local OPTIONS_FILE=${OPTIONS_FILE:-$OPTIONS_SAMPLE_FILE}
	local OPTIONS=""
	local TARGET_TYPE="file"

	if [ "$TARGET" == "" ]; then
		echo "usage: jslintr [-v|--verbose] target_path "
	else
		FILE=$(file -b $TARGET)
		if [ "$FILE" == "directory" ]; then
			# removing a possible final bar
			TARGET="$(echo $TARGET | sed 's/\/$//g')"
			TARGET_TYPE="directory"		
		fi
	
		if [ -r "$OPTIONS_FILE" ]; then
			OPTIONS=$(cat $OPTIONS_FILE | xargs echo | sed 's/ //g')
		fi
	
		#echo "debug: start_jslintr $TARGET $TARGET_TYPE $VERBOSE $OPTIONS"
		call_jslintr "$TARGET" "$TARGET_TYPE" "$VERBOSE" "$OPTIONS"
	fi
}

###
# Everything starts here
#
main "${1}" "${2}"

