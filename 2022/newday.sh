#!/usr/bin/env sh

DAY=$(date +"%d")
DAY_SHORT=$(date +"%d" | sed 's/^0*//')
TARGET_FILENAME="$DAY.rkt"
URL="https://adventofcode.com/2022/day/$DAY_SHORT"

cp boilerplate.rkt "$TARGET_FILENAME"

sed -e "/define DAY/s/0/$DAY/" boilerplate.rkt > "$TARGET_FILENAME"

sh download.sh

open "$URL"
