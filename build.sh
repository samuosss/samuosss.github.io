#!/bin/sh
# Rebuild index.html from ../portfolio/index.html (the artifact source) and copy referenced images.
set -e
cd "$(dirname "$0")"
SRC=../portfolio
for f in $(grep -o 'src="img/[^"]*"' $SRC/index.html | sed 's/src="//;s/"//' | sort -u); do cp "$SRC/$f" "$f"; done
cat > index.html <<'HEAD'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<link rel="icon" href="favicon.svg" type="image/svg+xml">
<link rel="icon" href="favicon.ico" sizes="any">
<link rel="apple-touch-icon" href="apple-touch-icon.png">
<meta name="theme-color" content="#07081a">
<meta property="og:title" content="Sami Boumaiza — Portfolio">
<meta property="og:description" content="Data & AI engineer for finance, ERP consultant, and sales & event planner.">
<meta property="og:image" content="https://samuosss.github.io/img/portrait.jpg">
<style>:root{color-scheme:dark;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%}[hidden]{display:none!important}</style>
HEAD
# title, metas and font links from the top of the source go in <head>; the rest goes in <body>
sed -n '1,/<style>/p' $SRC/index.html | sed '$d' >> index.html
echo '</head>' >> index.html
echo '<body>' >> index.html
sed -n '/<style>/,$p' $SRC/index.html >> index.html
printf '\n</body>\n</html>\n' >> index.html
