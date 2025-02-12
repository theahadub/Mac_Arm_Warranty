#!/bin/bash

# This EA will grab the current logged in user and find the Warranty plist
# This is useful to grab the coverageEndDate key from the plist and provide 
# a date in which warranty coverage should be ending
#
# Created 07.12.2023 @robjschroeder
#         https://techitout.xyz/2023/07/12/jamf-pro-get-mac-warranty-information/
# Modified 02.12.2025 @theahadub 
#    - file name for the plist changed adding a random string to the Warranty.plist
#    - Set your EA to Data Type = Date
#    - So far, this only works on Arm Macs
#
# expanded version of this script at https://community.jamf.com/t5/jamf-pro/command-line-to-show-the-applecare-status-and-expirate-date-for/m-p/279161

# Get the current logged in user
loggedInUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name / { print $3 }' )

# Find the coverage end date key in Warranty.plist
coverageEndDate=$( /usr/bin/defaults read /Users/$loggedInUser/Library/Application\ Support/com.apple.NewDeviceOutreach/*Warranty.plist coverageEndDate )

# Format the EPOCH time to something readable
formattedTime=$(date -jf %s $coverageEndDate "+%F %T")

echo "<result>$formattedTime</result>"

exit 0
