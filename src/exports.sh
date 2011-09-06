
###
# Setting up vars
#
# JSLINTR_ROOT=/opt/local/lib/jslint/
# OPTIONS_FILE=/opt/local/etc/options.sample
#
export JSLINTR_ROOT=${JSLINTR_ROOT:-$(pwd -P)}
export JSLINTR_LIB="$JSLINTR_ROOT/libs/"
export SAMPLE_OPTIONS_FILE="${JSLINTR_ROOT}/etc/options.sample"
#export OPTIONS_FILE="./jslint_options"

export RHINO="$JSLINTR_LIB/js.jar"
export JSLINT="$JSLINTR_LIB/jslint.js"
export RHINO_JSLINT="$JSLINTR_LIB/rhino_jslint.js"

export GREEN="\e[0;32m"
export RED="\e[0;31m"
export NC="\e[0m"

export FIND=find
export EGREP=egrep
export PWD=pwd
export CHMOD=chmod
export MKTEMP=mktemp
export SED=sed
export CAT=cat
export RM=rm
export PRINTF=printf