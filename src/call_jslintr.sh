GTAP_FILE=""
FAILS=0
SUCCESS=0
ACTUAL=1
TOTAL=0

function tap_file_create () {
    local TFILE="${1}"
    touch $TFILE
    
    # setting the global var
    GTAP_FILE=$TFILE
    echo "TAP version 13" > $GTAP_FILE
    echo "1..$TOTAL" >> $GTAP_FILE
}

function init_tap_file () {
    #echo "analyzing tap: ${1}"
    local TAP_TARGET="${1}"
    
    if [ -z "$TAP_TARGET" ]; then
        #echo " - No TAP target"
        return 0;
    fi
    
    local TYPE=$(file -b $TAP_TARGET)
    if [ "$TYPE" == "directory" ]; then
        #echo "No worries.. We gonna create it for you! ($TAP_FILE)"
        tap_file_create "$TAP_TARGET/jslintr.tap"
        return 1
    elif [ $(echo $TAP_TARGET | grep -n ".tap") ]; then
        #echo "It's a TAP! ($TAP_TARGET)"
        tap_file_create "$TAP_TARGET"
        return 1
    else
        #echo "nothing"
        return 0
    fi
}

function write_test_on_tap () {
    local RESULT="${1}"
    
    if [ ! -z $GTAP_FILE ]; then
        echo $RESULT >> $GTAP_FILE
    fi
}

function add_fail () {
    local FILE_NAME="${1}"
    local DETAILS="${2}"
    
    FAILS=$(($FAILS+1))
    
    write_test_on_tap "not ok $ACTUAL - $FILE_NAME"
}

function add_success () {
    local FILE_NAME="${1}"
    
    SUCCESS=$(($SUCCESS+1))
    
    write_test_on_tap "ok $ACTUAL - $FILE_NAME"
}

###
# Main function
#
function call_jslintr () {
	local TARGET=${1}
	local TYPE=${2}
	local VERBOSE=${3}
	local OPTIONS=${4}
	local TAP=${5}
	local COUNT=-1
		
    ${PRINTF} "\n====+> Starting JSLintr. \n\n    \"WARNING! JSLint will hurt your feelings.\" - Douglas Crockford \n\n"

	if [ "$TYPE" == "file" ]; then
		jslintr "${TARGET}" "${VERBOSE}" "${OPTIONS}"
	else
	    FILES=$( ${FIND} ${TARGET} -type f -name '*.js' | ${EGREP} -v '\.svn' )
	    TOTAL=$( echo $FILES | wc -w | xargs echo )
	    
	    init_tap_file "${TAP}"

	    for JS_FILE in $FILES;
	    do
			# jslinting file
			# echo "DEBUG: jslintr ${JS_FILE} ${VERBOSE} ${OPTIONS}"
			jslintr "${JS_FILE}" "${VERBOSE}" "${OPTIONS}"
			
			ACTUAL=$(($ACTUAL+1))
	    done
	fi

    if [ "$TYPE" == "directory" ];
    then
    	${PRINTF} "\n\n===+> JSLintr Complete: ${TOTAL} tests done! ${RED}${FAILS} failed${NC}, ${GREEN}${SUCCESS} passed${NC}. \n"
	else
		${PRINTF} "\n\n===+> JSLintr Done! \n"
	fi
}