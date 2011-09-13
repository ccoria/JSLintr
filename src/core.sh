
function has_jslint_errors () {
  LINTRESULTS="${1}"

  JSLINT_INDEX=$(expr "$LINTRESULTS" : "OK")

  if [ "$JSLINT_INDEX" -eq 0 ]
  then 
      return 0
  else
      return 1
  fi 
}

function verbose_output () {
  # naming parameters
  FILENAME="${1}"
  LINTRESULTS="${2}"

  if has_jslint_errors "$LINTRESULTS"
  then
      RESULT="${RED}FAIL${NC} - $LINTRESULTS\n\n"
  else
      RESULT="${GREEN}OK${NC}\n"
  fi

  printf "     - $(ls ${FILENAME}): ${RESULT}"
}

function concise_output () {
  # naming parameters
  FILENAME="${1}"
  LINTRESULTS="${2}"

  if has_jslint_errors "$LINTRESULTS"
  then
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

  local LINT_RESULT=$(java -jar ${RHINO} -f ${JSLINT} ${RHINO_JSLINT} ${TEMP_FILE})

  if [ "$VERBOSE" -eq 0 ]
  then
      concise_output "${REAL_FILE}" "${LINT_RESULT}"
  else
      verbose_output "${REAL_FILE}" "${LINT_RESULT}"
  fi
}

function jslintr () {
	local FILE_NAME=${1}
	local VERBOSE_MODE=${2}
	local OPTIONS=${3}	
	
	TEMPFILE=$(${MKTEMP} /tmp/jslint.XXXXXXXXXX) && {
  		echo "/*jslint ${OPTIONS} */" > "${TEMPFILE}"
  		${CAT} "${FILE_NAME}" >> "${TEMPFILE}"
  		runjslint "${TEMPFILE}" "${FILE_NAME}" "$VERBOSE_MODE"
  		${RM} -f "${TEMPFILE}"
	}
}
