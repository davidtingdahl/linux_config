#!/bin/bash
set -ex

[[ $# != 3 ]] && echo "Usage: $0 file1.mp4 file2.mp4 output.mp4" && exit
ffmpeg -i $1 -i $2 -filter_complex '[0:v]pad=iw*2:ih[int];[int][1:v]overlay=W/2:0[vid]' -map [vid]   -c:v libx264   -crf 23   -preset veryfast   $3
