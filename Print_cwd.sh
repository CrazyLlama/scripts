#!/usr/bin/env bash

## Should probably make the "libexec" portion take user input && increase output to exe as well

array=( $(ps faux | grep libexec | awk '{print $2}' | sed 's/^/\/proc\//g') )

echo ${array[@]}

for i in ${array[@]};
do
    echo $(ls -al $i | grep cwd | awk '{print $11}')
done
