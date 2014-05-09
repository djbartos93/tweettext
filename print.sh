#!/bin/bash

#this is a testing script ONLY.
#to be used to test different imagemagick commands
#and differnt pbm to rwa conversions.

echo "making some pbm files from the text output file"

#This is the guts of the operation. converiting the text file to a pbm
convert -size 600  -pointsize 40 caption:@/home/erbartos/twitprint/tweettext/tweet.txt print.pbm

echo "lets print the image!"

#changing these paramiters doesnt do much, but it makes you feel special
cat print.pbm | pnmtoplainpnm | pbm2lwxl 900 | lp -o raw

echo "DONE"
