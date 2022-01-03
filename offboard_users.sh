#!/bin/bash
#This script performs a number of offboarding tasks for employees leaving Owl Labs

gam="$HOME/bin/gam/gam"

# Enter user to deprovision
echo "Enter username you wish to deprovision (first.last without domain):"
read username
email=$username@owllabs.com

# Enter forwarding recipient
echo "Enter email address of forwarding recipient:"
read forwardingemail

#Confirm username before deprovisioning
read -r -p "Do you want to deprovision $email ? [y/n] " response
if [[ $response =~ [nN] ]]
  then
		echo "Exiting"
		exit
fi

##Starting deprovision
echo "Deprovisioning " $email

#Resetting cookies to sign user out of account
echo "Resetting cookies to sign $email out of account"
$gam user $email signout 
echo "Reset cookies to sign out $email"| tee -a /tmp/$username.txt

# Changing user's password to random
echo "Changing "$email"'s password to something random"
$gam update user $email password random | tee -a /tmp/$username.txt
echo "Changed password"

#Resetting cookies to sign user out of account
echo "Resetting cookies to sign $username out of account"
$gam user $email signout 
echo "Reset cookies to sign out $username"| tee -a /tmp/$username.txt

# Changing user's password to random
echo "Changing "$username"'s password to something random"
$gam update user $username password random | tee -a /tmp/$username.txt

# Changing account recovery info 
echo "Changing "$username"'s account recovery info to TechOps-owned email and phone number"
$gam update user $username recoveryemail techops-licensing@owllabs.com
$gam update user $username recoveryphone 18574195147
echo "Recovery email and phone have been updated" | tee -a /tmp/$username.txt

# Revoking all application specific passwords, 2SV Backup Codes and OAuth Tokens
echo "Revoking all application specific passwords, 2SV Backup Codes and OAuth Tokens"
$gam user $email deprovision
echo "All app-specific passwords, 2SV backup codes, and OAuth tokens have been revoked" | tee -a /tmp/$username.txt

# Removing user from all Google Groups
echo "Removing $username from all Google Groups"
$gam user $email delete groups
echo "Removed $username from all groups" | tee -a /tmp/$username.txt

# Setting email forwarding
echo "Setting email forwarding to $forwardingemail"
$gam user $email add forwardingaddress $forwardingemail
$gam user $email forward on $forwardingemail keep
echo "Successfully set email forwarding to $forwardingemail" | tee -a /tmp/$username.txt

## Completion
echo "Offboarding complete for $username"
