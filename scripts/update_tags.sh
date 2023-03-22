#/usr/bin/bash


GIT_DIR=$(git rev-parse --show-toplevel)

FILE_TYPES='.\.cpp$\|.\.h$\|.\.cu$\|.\.py$'

SCRIPT_DIR="$(readlink -m "$(dirname "$0")")"

export GTAGSFORCECPP
export GTAGSCONF=$SCRIPT_DIR/gtags.conf


[[ ! -d "$GIT_DIR" ]] && echo "Not a git repo" && exit 1
(
    cd $GIT_DIR

    if [ $(basename $PWD) == "src" ]
       then
          # Project files
          git ls-files |  grep --color=no $FILE_TYPES > gtags.files
       fi

    gtags #-i
    rm -f gtags.files
)

# exteral
EXTERNALS="\
googletest \
opencv \
rapidcheck \
ceres \
pcl \
com_gitlab_libeigen_eigen \
nvpdk_latest_cuda_x86_64_linux \
cs*.7.6/*amd* \
"

(
    cd /home/s0000413/.cache/bazel/_bazel_s0000413/97e8f4cc27a395cdfb4287ada735f9db/external

    rm -f gtags.files
    for ext in $EXTERNALS
    do
        find $ext  -name *.h -or -name *.hpp -or -name *.cpp > $ext.tmp
        cat $ext.tmp >> gtags.files
        wc -l $ext.tmp
        rm $ext.tmp
    done
    time gtags -i

)
