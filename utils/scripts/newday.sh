#!/usr/bin/env sh

EXT="livemd"
DAY=$(date +"%d")
YEAR=$(date +"%Y")
DAY_SHORT=$(date +"%d" | sed 's/^0*//')
TARGET_FILENAME="./$YEAR/$DAY.$EXT"
URL="https://adventofcode.com/$YEAR/day/$DAY_SHORT"

sed -e "/define DAY/s/0/$DAY/" "boilerplate.$EXT" > "$TARGET_FILENAME"

sh download.sh

open "$URL"
