#!/usr/bin/env bash

## Need to add user input for file parsing or even pulling the needful out automatically
## This only works with `gzuncompress(base64_decode(` for now

## Example start of line: 
## `eval(gzuncompress(base64_decode('`

array=( (grep '((eval.*(base64_decode|gzinflate|\$_))|\$[0O]{4,}|FilesMan|JGF1dGhfc|IIIl|die\(PHP_OS|posix_getpwuid|Array\(base64_decode|document\.write\("\\u00|sh(3(ll|11)))' . -lroE --include=*.php*) )

# Base64 decode the file and output to raw zlib format, then prepend gzip header and uncompress

for i in $array[@]; 
do
  grep
done

base64 -d file.b64 | printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" | cat - /tmp/zlib.raw | gzip -dc > /tmp/out.txt

# What's it got?
cat /tmp/out.txt

echo "see /tmp/out.txt for full output"
