#!/bin/bash
set -e

ffmpeg-normalize "$1" --keep-lra-above-loudness-range-target -o "/tmp/normalize-temp.wav"
ffmpeg -i "/tmp/normalize-temp.wav" "/tmp/normalize-temp.ogg"
optivorbis "/tmp/normalize-temp.ogg" "$2"

rm -f "/tmp/normalize-temp.wav"
rm -f "/tmp/normalize-temp.ogg"