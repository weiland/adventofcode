#!/usr/bin/env sh

YEAR=$(date +"%Y")
PREFIX="https://adventofcode.com/$YEAR/day/"
SUFFIX='/input'

DAY=$(date +"%d")
DAY_SHORT=$(date +"%d" | sed 's/^0*//')

URL="$PREFIX$DAY_SHORT$SUFFIX"

TARGET="./$YEAR/input/$DAY.txt"

SESSION=$(cat session.txt)

DATE="date +%Y:%m:%d"

curl "$URL" -H "Cookie: session=$SESSION" --silent --output "$TARGET" \
&& echo "Input downloaded"
