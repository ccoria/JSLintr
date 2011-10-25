
###
# Verifying usage and calling jslintr =)
#
function main () {
    
    local VERBOSE=0
    local TAP=""
    local TARGET=""
	
	###
	# Verifying optional parameters
	#
	while [ $# -gt 0 ]
    do
        # echo "$# ($1)"
    	case "$1" in 
    		"-v" | "--verbose")		shift
    								VERBOSE=1
    								;;
            "-o" | "--options")		shift
    								PARAMS_OPT_FILE="$1"
    								shift
    								;;
    		"--tap" | "-tap")    	shift
    								TAP="$1"
    								shift							
    								;;						
    		*)                      TARGET="$1"
    		                        break
    								;;
    	esac
    done
    
    # echo "==========================================="
    # echo "=== opts: $PARAMS_OPT_FILE"
    # echo "=== verbose: $VERBOSE"
    # echo "=== tap: $TAP"
    # echo "=== target: $TARGET"
    # echo "==========================================="
	
	# local TARGET="${1}"
	# local PARAM_OPT_FILE="${2}"
	local OPTIONS_FILE=${PARAM_OPT_FILE:-$BIN_OPTIONS_FILE}
	local OPTIONS=""
	local TARGET_TYPE="file"
	local USAGE=" Usage: jslintr [-v|--verbose] [-o|--options options_file] [-tap target_tap_file] target_path\n"

	if [ "$TARGET" == "" ]; then
		printf "$USAGE"
	elif [ ! -s "$TARGET" ]; then
		printf "\n JSLintr: Target not found or empty\n"
		printf "$USAGE"
	else
		FILE_TARGET=$(file -b $TARGET)
		if [ "$FILE_TARGET" == "directory" ]; then
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
	
        # echo "debug: start_jslintr $TARGET $TARGET_TYPE $VERBOSE $OPTIONS $TAP"
		call_jslintr "$TARGET" "$TARGET_TYPE" "$VERBOSE" "$OPTIONS" "$TAP"
	fi
}

###
# Everything starts here
#
main "${1}" "${2}" "${3}" "${4}" "${5}" "${6}"

