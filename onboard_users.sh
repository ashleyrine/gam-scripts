#!/bin/bash
#This script performs a number of onboarding tasks for new hires at Owl Labs

gam="$HOME/bin/gam/gam"

##Google user creation

#Enter name of new hire
echo "User's first name (with no spaces):"
read firstname
echo "User's last name (with no spaces):"
read lastname
username=$firstname.$lastname
email=$username@owllabs.com

#Confirm username before creation
read -r -p "Do you want to create $username ? [y/n] " response
if [[ $response =~ [yY] ]]
  then
      $gam create user $email firstname $firstname lastname $lastname password random changepassword on
  else
      echo "Exiting"
      exit
fi

#Move user to top-level OU (full-time employee) or Restricted Users OU (contractors, etc)
read -r -p "Is this a full time employee? [y/n] " response
if [[ $response =~ [yY] ]]
  then
      $gam update org / add users $username
      $gam update group fulltimeperm@owllabs.com add member user $email
      echo "Moved user to top-level OU, adding to fulltimeperm@"
  else
      $gam update org "/Restricted Users" add users $username
      $gam update group consultants@owllabs.com add member user $email
      echo "Moved user to Restricted Users OU, adding to consultants@"
      exit
fi

##Add user to Google groups

#team@ and owls@
echo "Adding user to company-wide groups - team@, owls@"
$gam update group team@owllabs.com add member user $email
$gam update group owls@owllabs.com add member user $email

#nest-owls@
read -r -p "Is this user based in the Boston area? [y/n] " response
if [[ $response =~ [yY] ]]
  then
      $gam update group nest-owls@owllabs.com add user $username
  else
      echo "Not added to nest-owls@"
fi

#engineering@
read -r -p "Is this user part of the Engineering org ? [y/n] " response
if [[ $response =~ [yY] ]]
  then
      $gam update group engineering@owllabs.com add user $username
      $gam update user $email org "/Full Time Employees/Engineering"
      echo "Added user to engineering@, moved to Engineering OU"
  else
      echo "No changes made, exiting"
fi

echo "Account creation complete!"