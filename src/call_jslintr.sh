

function create_tap_file () {
    echo "analyzing tap: ${1}"
    local TAP_TARGET="${1}"
    
    if [ -z "$TAP_TARGET" ]; then
        echo " - No TAP target"
        return 0;
    fi
    
    local TYPE=$(file -b $TAP_TARGET)
    if [ "$TYPE" == "directory" ]; then
        echo "No worries.. We gonna create it for you!"
        # create file and set global
        return 1
    elif [ $(echo $TAP_TARGET | grep -n ".tap") ]; then
        echo "It's a TAP!"
        # just set the global
        return 1
    else
        return 0
        echo "nothing"
    fi
}

FAILS=0
SUCCESS=0
TOTAL=0
function add_fail () {
    FAILS=$(($FAILS+1))
    TOTAL=$(($TOTAL+1))
}

function add_success () {
    SUCCESS=$(($SUCCESS+1))
    TOTAL=$(($TOTAL+1))
}

###
# Main function
#
function call_jslintr () {
	local TARGET=${1}
	local TYPE=${2}
	local VERBOSE=${3}
	local OPTIONS=${4}
	local TAP=$(create_tap_file "${5}")
	local COUNT=-1
	
	# echo $TAP
		
    ${PRINTF} "\n====+> Starting JSLintr. \n\n    \"WARNING! JSLint will hurt your feelings.\" - Douglas Crockford \n\n"

	if [ "$TYPE" == "file" ]; then
		jslintr "${TARGET}" "${VERBOSE}" "${OPTIONS}"
	else
	    for JS_FILE in $( ${FIND} ${TARGET} -type f -name '*.js' | ${EGREP} -v '\.svn' );
	    do
			# jslinting file
			# echo "DEBUG: jslintr ${JS_FILE} ${VERBOSE} ${OPTIONS}"
			jslintr "${JS_FILE}" "${VERBOSE}" "${OPTIONS}"
	    done
	fi

    if [ "$TYPE" == "directory" ];
    then
    	${PRINTF} "\n\n===+> JSLintr Complete: ${TOTAL} tests done! ${RED}${FAILS} failed${NC}, ${GREEN}${SUCCESS} passed${NC}. \n"
	else
		${PRINTF} "\n\n===+> JSLintr Done! \n"
	fi
}