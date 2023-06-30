#!/bin/bash
set -eu

SOURCE="$1"
TARGET="$2"

# blog text width
magick "$SOURCE" -format jpg -resize 720 "$TARGET-small.jpg"
# 4k width
magick "$SOURCE" -format jpg -resize 3840 "$TARGET-large.jpg"
