#!/usr/bin/env sh


PREFIX='https://adventofcode.com/2020/day/'
SUFFIX='/answer'

DAY=$(date +"%d" | sed 's/^0*//')

URL="$PREFIX$DAY$SUFFIX"

SESSION=$(cat session.txt)

ANSWER="$1"
LEVEL="$2"

echo "It's day $DAY and the answer for part '$LEVEL' is = $ANSWER \n"

curl -i -X POST "$URL" -H "Cookie: session=$SESSION" --data-raw "level=$LEVEL&answer=$ANSWER"
