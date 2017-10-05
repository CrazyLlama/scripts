#!/usr/bin/env bash

## Should probably make the "libexec" portion take user input && increase output to exe as well
## Also need to add user options and whether they want anything removing just to make lives easier

# Stick processes output into array
array=( $(ps faux | grep smtp | grep -v root | awk '{print $2}' | sed 's/^/\/proc\//g') )

# https://media.giphy.com/media/26DOs997h6fgsCthu/giphy.gif
echo ${array[@]}
echo ""

# Then give it to the user
for i in ${array[@]};
do
    echo $(ls -al $i | grep cwd | awk '{print $11}')
done
