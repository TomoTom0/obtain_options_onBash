# obtain_options_onBash
obtain options for bash function and scripts

```bash

dir_path=$(
    cd $(dirname ${BASH_SOURCE:-$0})
    pwd
)
source ${dir_path}/../../lib/obtain_options.sh

alias yt_newton_1="_Newton_1_pipeline"
alias yt_newton_pipeline="_Newton_1_pipeline"
function _Newton_1_pipeline() {
    ## はじめの処理
    # args: all_cams=(mos1 mos2 pn)
    # args: FLAG_clean=false

    # ---------------------
    ##     obtain options
    # ---------------------

    function __usage() {
        echo "Usage: ${FUNCNAME[1]} [-h,--help] [--ignore mos1,mos2,pn]" 1>&2
        cat <<EOF

${FUNCNAME[1]}
    execute first pipeline for EMOS and EPN


Options
--ignore mos1,mos2,pn
    skip the process of selected cameras

--clean
    clean "fit/*"

EOF
        return 0
    }

    # arguments settings
    declare -A flagsAll=(
        ["h"]="help"
        ["--help"]="help"
        ["--ignore"]="ignore"
        ["--clean"]="clean"
    )
    declare -A flagsArgDict=(
        ["ignore"]="cameras"
    )

    # arguments variables
    declare -i argc=0
    declare -A kwargs=()
    declare -A flagsIn=()

    declare -a allArgs=($@)

    __obtain_options allArgs flagsAll flagsArgDict argc kwargs flagsIn

    if [[ " ${!flagsIn[@]} " =~ " help " ]]; then
        __usage
        return 0
    fi

    # ---------------------
    ##         main
    # ---------------------
    all_cams=(mos1 mos2 pn)
    FLAG_clean=false
    if [[ "x${FUNCNAME}" != x ]]; then
        if [[ -n ${kwargs[ignore__cameras]} ]]; then
            all_cams=$(echo ${kwargs[ignore__cameras]} | grep -o -E "(mos1|mos2|pn)")
        fi
        if [[ -n ${flagsIn[clean]} ]]; then
            FLAG_clean=true
        fi
    fi
    
    # FUNCTION CONTENT
}

```