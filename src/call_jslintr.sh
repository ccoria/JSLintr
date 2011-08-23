#!/usr/bin/env sh

###
# Main function
#
function call_jslintr () {
	local TARGET=${1}
	local TYPE=${2}
	local VERBOSE=${3}
	local OPTIONS=${4}
	local COUNT=-1
		
    ${PRINTF} "\n====+> Starting JSLint. \n\n    \"WARNING! JSLint will hurt your feelings.\" - Douglas Crockford \n\n"

	if [ "$TYPE" == "file" ]; then
		${CORE} "${TARGET}" ${VERBOSE} "${OPTIONS}" ;
	else
    	COUNT=0
	    for JS_FILE in $( ${FIND} ${TARGET} -type f -name '*.js' | ${EGREP} -v '\.svn' );
	    do
	        COUNT=$(($counter+1));
			
			# jslinting file
			jslintr "${JS_FILE}" "${VERBOSE}" "${OPTIONS}"
	    done
	fi

    if [ $COUNT -gt 0 ];then
    	${PRINTF} "\n\n===+> JSLintr Complete: ${counter} tests done! \n"
	else
		${PRINTF} "\n===+> JSLintr Done! \n"
	fi
}