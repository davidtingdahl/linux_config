#/usr/bin/bash


git_dir=$(git rev-parse --show-toplevel)

[[ ! -d "$git_dir" ]] && echo "Not a git repo" && exit 1

(
    cd "$git_dir"/visual_odometry/cpp
    find -type f -iname "*.h"  -or -iname "*.cc" | etags -
)
echo "$git_dir"/visual_odometry/cpp/TAGS
