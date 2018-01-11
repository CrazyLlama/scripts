#!/usr/bin/env bash

proc_array=( $(ps faux | awk '{print $2}' | grep -v "PID") )

for i in ${proc_array[@]};
do
    echo ""
    echo "process name - $(ps faux | grep $i | awk '{print $11}' | grep -v '\_')"
    echo "files in use by process - $(lsof –Pnp $i | grep -Ev 'pipe|/dev/null')"
    echo ""
done
