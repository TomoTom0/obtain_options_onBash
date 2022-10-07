#!/bin/bash

function example_function(){
    ## example function
    # ---------------------
    ##     obtain options
    # ---------------------

    function __usage() {
        cat <<EOF
Usage: ${FUNCNAME[1]} [-h.--help] []

show your username

Options
--ignoreUnknown
    ignore unknown options instead of storing UNKNOW__flag

--allowHyphen
    allow arguments after specific options start with hyphen

-h,--help
    show this message

EOF
        return 0
    }

    # arguments settings
    declare -A _flagsAll=(
        ["h"]="help"
        ["--help"]="help"
        ["--ignoreUnknown"]="ignoreUnknown"
        ["--allowHyphen"]="allowHyphen"
    )
    declare -A _flagsArgDict=(
    )

    # arguments variables
    declare -i _argc=0
    declare -A _kwargs=()
    declare -A _flagsIn=()

    declare -a _allArgs=($@)

    __obtain_options _allArgs _flagsAll _flagsArgDict _argc _kwargs _flagsIn

    if [[ " ${!flagsIn[@]} " =~ " help " ]]; then
        __usage
        return 0
    fi

    # ---------------------
    ##         main
    # ---------------------
    FLAG_ignoreUnknown=false
    FLAG_allowHyphen=false
    if [[ -n "${_flagsIn[ignoreUnknown]}" ]]; then
        FLAG_ignoreUnknown=true
    fi
    if [[ -n "${_flagsIn[allowHyphen]}" ]]; then
        FLAG_allowHyphen=true
    fi
}