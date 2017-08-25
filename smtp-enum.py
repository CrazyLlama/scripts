#!/usr/bin/python
import socket
import sys
if len(sys.argv) != 3:
 print "Usage: smtp-enum.py <users-file> <IP-address>"
 sys.exit(0)

# Open passed file
infile = open(sys.argv[1],"r")

for nline in infile.readlines():

 linen = nline.split()

 # Create Socket
 s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
 # Connect to the Server
 connect=s.connect((sys.argv[2],25))
 # Receive the banner
 banner=s.recv(1024)
 print banner
 # VRFY a user
 s.send('VRFY ' + linen[0] + '\r\n')
 result=s.recv(1024)
 print result

# Close the socket
s.close()
