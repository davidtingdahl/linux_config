#!/bin/bash

diff_files=$(git diff --name-only HEAD^);

diff_files_with_delimiter=$(echo $diff_files | tr ' ' '+')

#echo $diff_files_with_delimiter
modified_packages=$(./bazel.py query $diff_files_with_delimiter --output=package --keep_going)

targets=""
for package in $modified_packages
do
    targets="$targets\n$package/..."
done
#targets=${modified_packages/" "/hej/}:



echo -e $targets



