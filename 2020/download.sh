#!/usr/bin/env sh


PREFIX='https://adventofcode.com/2020/day/'
SUFFIX='/input'

DAY=$(date +"%d" | sed 's/^0*//')

URL="$PREFIX$DAY$SUFFIX"

TARGET="input/$DAY.txt"


SESSION=$(cat session.txt)


DATE="date +%Y:%m:%d"

curl "$URL" -H "Cookie: session=$SESSION" --output "$TARGET"
