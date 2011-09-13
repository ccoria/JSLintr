
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
	local PARAM_OPT_FILE="${2}"
	local OPTIONS_FILE=${PARAM_OPT_FILE:-$BIN_OPTIONS_FILE}
	local OPTIONS=""
	local TARGET_TYPE="file"

	if [ "$TARGET" == "" ]; then
		echo "usage: jslintr [-v|--verbose] target_path"
	else
		FILE=$(file -b $TARGET)
		if [ "$FILE" == "directory" ]; then
			# removing a possible final bar
			TARGET="$(echo $TARGET | sed 's/\/$//g')"
			TARGET_TYPE="directory"		
		fi
	    
	    #echo "OPTIONS: $OPTIONS_FILE"
		if [ -f "$OPTIONS_FILE" ]; then
			OPTIONS=$(cat $OPTIONS_FILE | sed 's/\/\/.*$//g' | xargs echo | sed 's/ //g');
			#printf "OPTIONS: $OPTIONS"
		else
		    echo "No options file loaded!"
		fi
	
		#echo "debug: start_jslintr $TARGET $TARGET_TYPE $VERBOSE $OPTIONS"
		call_jslintr "$TARGET" "$TARGET_TYPE" "$VERBOSE" "$OPTIONS"
	fi
}

###
# Everything starts here
#
main "${1}" "${2}" "${3}"

