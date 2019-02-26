#/usr/bin/bash

git_dir=$(git rev-parse --show-toplevel)

[[ ! -d "$git_dir" ]] && echo "Not a git repo" && exit 1

(
    cd "$git_dir"
    find -type f -iname "*.h"  -or -iname "*.cc" -or -iname "*.py" | grep -v "visual_odometry/reports" | etags -o /tmp/TAGS -
)
echo "$git_dir"/core/src/TAGS
