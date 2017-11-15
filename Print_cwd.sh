#!/usr/bin/env bash

## Should probably make the "smpt" grep portion take user input && increase output to exe as well
## Also need to add user options and whether they want anything removing just to make lives easier

echo "Enter the string you would like to search the process list for:"

read proc

# Stick processes output into array
array=( $(ps faux | grep $proc | grep -v root | awk '{print $2}' | sed 's/^/\/proc\//g') )

# https://media.giphy.com/media/26DOs997h6fgsCthu/giphy.gif
echo ${array[@]}
echo ""

# Then give it to the user
for i in ${array[@]};
do
    echo $(ls -al $i | grep cwd | awk '{print $11}')
done

## Remotely executing this: bash <(curl -s <RAW-LINK>)
