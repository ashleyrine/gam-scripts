#!/bin/bash
#This script sets an OOO reply for the specified user / group

gam="$HOME/bin/gam/gam"

$gam group it@owllabs.com vacation on subject "Owl Labs closed on Monday, October 11th"
 message "Thanks for reaching out to Owl Labs!  Owl Labs will be closed Monday, October 11th for the holiday. We look forward to connecting with you on Tuesday. Thank you for your patience!" html
  