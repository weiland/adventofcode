#!/usr/bin/env sh

YEAR=$(date +"%Y")
PREFIX="https://adventofcode.com/$YEAR/day/"
DAY=$(date +"%d")
DAY_SHORT=$(echo "$DAY" | sed 's/^0*//')
URL="$PREFIX$DAY_SHORT"
SESSION=$(cat session.txt)
HTML=$(curl "$URL" -H "Cookie: session=$SESSION")
TARGET_FILENAME="./$YEAR/$DAY.rkt"

if [[ $HTML != *"Both parts of this puzzle are complete"* ]]; then
  echo "Did you submit both solutions?"
  exit 1;
fi

git add "$TARGET_FILENAME"

git commit -m "Add solution for day $DAY_SHORT" \
&& git push
