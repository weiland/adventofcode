#!/usr/bin/env sh

set -e

EXT="livemd"

YEAR=$(date +"%Y")
PREFIX="https://adventofcode.com/$YEAR/day/"
DAY=$(date +"%d")
DAY_SHORT=$(echo "$DAY" | sed 's/^0*//')
URL="$PREFIX$DAY_SHORT"
SESSION=$(cat session.txt)
echo '⏳'
HTML=$(curl "$URL" --silent -H "Cookie: session=$SESSION")
TARGET_FILENAME="./$YEAR/$DAY.$EXT"

if [[ $HTML != *"Both parts of this puzzle are complete"* ]]; then
  echo "Did you submit both solutions?"
  exit 1;
fi

git add "$TARGET_FILENAME"

git commit -m "feat(day$DAY): add solution for part one and two" \
&& git push
