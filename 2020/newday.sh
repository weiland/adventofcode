#!/usr/bin/env sh

DAY=$(date +"%d")
TARGET_FILENAME="$DAY.rkt"

cp boilerplate.rkt "$TARGET_FILENAME"

sed -ie "/define DAY/s/0/$DAY/" "$TARGET_FILENAME"

sh download.sh
