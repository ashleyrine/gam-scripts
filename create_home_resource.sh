#!/bin/bash
#This script creates a resource for an employee's MHQ

gam="$HOME/bin/gam/gam"

#Enter employee name
echo "User's first name (with no spaces):"
read firstname
echo "User's email address:"
read email

#$gam create resource $firstname-place "$firstname's Place" type "Personal Office" category CONFERENCE_ROOM building "Homes" capacity "1" floor "1" 

$gam info resource $firstname-place | grep -i "resourceEmail:" 

echo "Copy/paste the resource email:"
read resourceemail

$gam calendar $resourceemail add editor $email

