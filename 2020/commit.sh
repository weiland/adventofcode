#!/usr/bin/env sh

PREFIX='https://adventofcode.com/2020/day/'
DATE=$(date +"%d")
DAY=$(echo "$DATE" | sed 's/^0*//')
URL="$PREFIX$DAY"
SESSION=$(cat session.txt)
HTML=$(curl "$URL" -H "Cookie: session=$SESSION")
TARGET="input/$DAY.txt"
TARGET_FILENAME="$DATE.rkt"

if [[ $HTML != *"Both parts of this puzzle are complete"* ]]; then
  echo "Did you submit both solutions?"
  exit 1;
fi

git add "$TARGET"
git add "$TARGET_FILENAME"

git commit -m "Add solution for day $DAY"

git push
