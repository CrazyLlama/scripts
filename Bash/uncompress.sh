#!/usr/bin/env bash

## Need to add user input for file parsing or even pulling the needful out automatically
## For now it finds limited types of files and attempts to decode them
##
## Example start of line: 
## `eval(gzuncompress(base64_decode('`
##

# Put API key here:
API="<API-KEY-HERE>"

alias find_evil="grep '((eval.*(base64_decode|gzinflate|\$_))|\$[0O]{4,}|FilesMan|JGF1dGhfc|IIIl|die\(PHP_OS|posix_getpwuid|Array\(base64_decode|document\.write\("\\u00|sh(3(ll|11)))' . -lroE --include=*.php*"
array=( (find_evil) )

# Send off to decode on unphp.net API
for i in $array[@]; 
do
  curl  -o /tmp/out.$i -i -F api_key=$API -F file=@$i http://www.unphp.net/api/v2/post
done

# What's it got?
ls -al /tmp/out.*

echo "see /tmp/out.<filename> for full output"
