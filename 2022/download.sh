#!/usr/bin/env sh


PREFIX='https://adventofcode.com/2022/day/'
SUFFIX='/input'

DAY=$(date +"%d")
DAY_SHORT=$(date +"%d" | sed 's/^0*//')

URL="$PREFIX$DAY_SHORT$SUFFIX"

TARGET="input/$DAY.txt"


SESSION=$(cat session.txt)


DATE="date +%Y:%m:%d"

curl "$URL" -H "Cookie: session=$SESSION" --output "$TARGET"
