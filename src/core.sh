
function has_jslint_errors () {
    local LINTRESULTS="${1}"
    local JSLINT_INDEX=$(expr "$LINTRESULTS" : "OK")

    if [ "$JSLINT_INDEX" -eq 0 ]
    then 
      return 0
    else
      return 1
    fi 
}

function verbose_output () {
    # naming parameters
    local FILENAME="${1}"
    local HAS_ERROR="${2}"
    local LINTRESULTS="${3}"

    if [ "$HAS_ERROR" -eq 1 ]; then
        RESULT="${RED}FAIL${NC} - $LINTRESULTS\n\n"
    else
        RESULT="${GREEN}OK${NC}\n"
    fi

    printf "     - $(ls ${FILENAME}): ${RESULT}"
}

function concise_output () {
    # naming parameters
    local FILENAME="${1}"
    local HAS_ERROR="${2}"
    local LINTRESULTS="${3}"

    if [ "$HAS_ERROR" -eq 1 ]; then
        RESULT="${RED}FAIL${NC} at ${FILENAME} - $LINTRESULTS\n\n"
    else
        RESULT="${GREEN}.${NC}"
    fi

    printf "${RESULT}"
}

function runjslint () {
    # naming parameters
    local TEMP_FILE="${1}"
    local REAL_FILE="${2}"
    local VERBOSE_MODE=${3}
    local VERBOSE=${VERBOSE_MODE:-1}

    #local LINT_RESULT=$(java -jar ${RHINO} -f ${JSLINT} ${RHINO_JSLINT} ${TEMP_FILE})
    local LINT_RESULT=$(${V8} ${JSLINT} ${V8_JSLINT} -- ${TEMP_FILE})
    #local HAS_LINT_ERRORS=$(expr )

    if has_jslint_errors "$LINT_RESULT"; then
        #echo "fail"
        HAS_LINT_ERRORS=1
        add_fail
    else
        #echo "success"
        HAS_LINT_ERRORS=0
        add_success
    fi

    if [ "$VERBOSE" -eq 0 ]; then
        concise_output "${REAL_FILE}" "${HAS_LINT_ERRORS}" "${LINT_RESULT}"
    else
        verbose_output "${REAL_FILE}" "${HAS_LINT_ERRORS}" "${LINT_RESULT}"
    fi
}

function jslintr () {
    local FILE_NAME=${1}
    local VERBOSE_MODE=${2}
    local OPTIONS=${3}  
    
    TEMPFILE=$(mktemp /tmp/jslintr.XXXXXXXXXX) && {
        echo "/* jslint ${OPTIONS} */" > "${TEMPFILE}"
        cat "${FILE_NAME}" >> "${TEMPFILE}"
        runjslint "${TEMPFILE}" "${FILE_NAME}" "$VERBOSE_MODE"
        rm -f "${TEMPFILE}"
    }
}
