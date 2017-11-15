#/usr/bin/python
# Lets get those evil IPS!
# If you’re using Linux or BSD systems, check your favourite package repository for python-celementtree or py-celementtree packages
#
# Aggregation of bad IPs is what this is after, and that's what I'll make it do
#

import xml.etree.cElementTree as ET
import numpy as np
import sys
import os

# Lets get these bash piping arrays out of the way
arr_count = [count.split(',') for count in os.popen("grep host-deny.sh /var/log/messages | awk '{print $16}' | sort | uniq -c | sort -bgr")]
arr_IP = [count.split(',') for count in os.popen("grep host-deny.sh /var/log/messages | awk '{print $16}' | sort | uniq | sort -bgr")]

def xmlinitial(): # And here's the beginning of XML creation
	
	root = ET.Element("IP List")
	i = 0
	# Iterating through the array should be good times
	while i < len(arr_IP):
		Count = ET.SubElement(root, arr_count[i])
		IP = ET.SubElement(root, arr_IP[i])
		i += 1
	
	tree = ET.ElementTree(root)
	tree.write("/var/evilIPs.xml") # And off it goes, grew up so fast
	
	return 0 # Back to poppa
	
def xmlupdate(): # Fresh counts and IPs only pls ty
	
	# diff <(grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' <(sort -bgr <(grep host-deny.sh /var/log/messages | awk '{print $16}' | sort | uniq -c ))) <(grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /var/evilIPs.xml) 
	# Need to the equivalent of the following bash command to append to the XML
	# diff --unchanged-line-format= --old-line-format= --new-line-format='%L' /var/evilIPs.xml <(grep host-deny.sh /var/log/messages | awk '{print $16}' | sort | uniq | sort -bgr)
	# Which will add any brand new IPs onto the end of the current XML file
	# And from there check for any re-occurences and + that to current IP counts
	
	return 0 # All done here boys, time to pack up

def main(): # Everything important here pls
    
	if os.path.isfile(/var/evilIPs.xml) == true: # Check if we've already created the xml file
		xmlupdate()
	else # If yes then we'll work on updating it instead
		xmlinitial()

if __name__ == "__main__": # welcome to the MAIN frame... god I'm funny
    main() 
