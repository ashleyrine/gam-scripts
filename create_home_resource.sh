#!/bin/bash
#This script creates a resource for an employee's Owl

gam="$HOME/bin/gam/gam"

#Enter employee name
echo "User's first name (with no spaces):"
read firstname

$gam create resource $firstname-place "$firstname's Place" type "Personal Office" category CONFERENCE_ROOM building "Homes" capacity "1" floor "1" 
