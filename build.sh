#!/bin/sh
# Rebuild index.html from ../portfolio/index.html (the artifact source) and copy referenced images.
set -e
cd "$(dirname "$0")"
SRC=../portfolio
for f in $(grep -o 'src="img/[^"]*"' $SRC/index.html | sed 's/src="//;s/"//' | sort -u); do cp "$SRC/$f" "$f"; done
{ printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n<style>:root{color-scheme:dark;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n</head>\n<body>\n'; cat $SRC/index.html; printf '\n</body>\n</html>\n'; } > index.html
