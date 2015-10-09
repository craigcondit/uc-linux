#!/bin/sh

cat files.txt  | sed 's/.*://' | sort | uniq -c | egrep -v '^[ ]+1 ' | awk '{print "grep \""$2"\" files.txt"}' | sh | sed 's/:/ /' | sort -k2 -k1 > dups.txt

