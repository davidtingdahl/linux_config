set -ex

from=$1
to=$2


bazel.py query "allpaths($from, $to)" --notool_deps --output graph | dot -Tsvg > deps.svg
