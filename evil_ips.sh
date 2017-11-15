#!/usr/bin/env bash

# A little script to compare and gather evil IPs from /var/messages
# Use printf: www.in-ulm.de/~mascheck/various/echo+printf/
# Compare output and file, check for current occurences and add to counter if it exists. If not then append to end of the file

comparison_1() { # Add newly appearing IPs to the evilIPs var file aka checking for those freshly grown IPs
        printf "Comparing /var/messages with stored evilIPs"
        diff --unchanged-line-format= --old-line-format= --new-line-format='%L' /var/evilIPs.var <(grep host-deny.sh /var/log/messages | awk '{print $16}' | sort | uniq -c | sort -bgr) >> /var/evilIPs.var # Despite popular opinion, I'm dead inside but whatever works
}

comparison_2() { # Enumerate recurring IPs and add to count aka checking for those sad rotten IPs
        printf "Looking for any recurring IPs and enumerating"
        LOG_OUT=$(grep host-deny.sh /var/log/messages | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | awk '{print $16}' | sort | uniq -c | sort -bgr) # I get paid hourly
        VAR_OUT=$(grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /var/evilIPs.var)
        COMM_OUT=$(comm -12 <(sort $LOG_OUT) <(sort $VAR_OUT) | uniq -c | sort -n -r))
        # Remove any current occurences of the matching IPs and add back in with updated counters. 
        # I'll take a backup just in case as well. 
        # As this is going to be done just before log rotation this should be kind of ok
        sed -i.bak '/$(comm -12 <(sort $LOG_OUT) <(sort $VAR_OUT))/d' /var/evilIPs.var
        $COMM_OUT >> /var/evilIPs.var
}

if [ -f /var/evilIPs.var ]; then
        printf "File exists!"
else
        printf "\nNo IPs have been extracted, file has been renamed, or is missing.\n\nCreating evilIPs.var\n\n"
        printf  > /var/evilIPs.var
fi

comparison_1
comparison_2

sed -i '/^$/d' /var/evilIPs.var
# What can I say, I like to clean up after my sweet sweet victory
sort -n -r /var/evilIPs.var
