#!/usr/bin/env bash

## Need to add user input for file parsing or even pulling the needful out automatically
## This only works with `gzuncompress(base64_decode(` for now

## Example start of line: 
## `eval(gzuncompress(base64_decode('`

# Base64 decode the file and output to raw zlib format
base64 -d file.b64 > /tmp/zlib.raw

# Prepend gzip header and uncompress
printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" | cat - /tmp/zlib.raw | gzip -dc > /tmp/out.txt

# What's it got?
cat /tmp/out.txt
