
###
# Setting up vars
#

export RHINO="$JSLINTR_LIB/js.jar"
export JSLINT="$JSLINTR_LIB/jslint.js"
export RHINO_JSLINT="$JSLINTR_LIB/rhino_jslint.js"
export V8_JSLINT="$JSLINTR_LIB/v8_jslint.js"

export KERNEL=$(uname -s)
if [ $KERNEL == "Linux" ]
then
    export V8="$JSLINTR_LIB/d8_linux"
else
    export V8="$JSLINTR_LIB/d8"
fi

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