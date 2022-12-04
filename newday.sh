#!/usr/bin/env sh

DAY=$(date +"%d")
YEAR=$(date +"%Y")
DAY_SHORT=$(date +"%d" | sed 's/^0*//')
TARGET_FILENAME="./$YEAR/$DAY.rkt"
URL="https://adventofcode.com/$YEAR/day/$DAY_SHORT"

sed -e "/define DAY/s/0/$DAY/" boilerplate.rkt > "$TARGET_FILENAME"

sh download.sh

open "$URL"
