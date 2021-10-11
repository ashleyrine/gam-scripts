#!/bin/bash
#Testing nested if-else statements for onboarding


#Engineering user tasks
read -r -p "Is this user in the Engineering org? [y/n] " response
if [[ $response =~ [yY] ]]
	then
		$gam update group engineering@owllabs.com add member user $email
		echo "Added to engineering@"
elif
	then
		$gam 
	else
      echo "Exiting"
      exit
fi


echo -n "Enter a number: "
read VAR

if [[ $VAR -gt 10 ]]
then
  echo "The variable is greater than 10."
elif [[ $VAR -eq 10 ]]
then
  echo "The variable is equal to 10."
else
  echo "The variable is less than 10."
fi