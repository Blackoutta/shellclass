#!/bin/bash
# Creates a new user on the local system.

# Check root privilege (must be root)
if [[ "${UID}" != 0 ]]
then
    echo "You must be root to execute this script."
    exit 1
fi

# Getting user input
read -p "Please enter the username for the new user to use: " NEW_USERNAME
read -p "Please enter the real name of the person this account is for: " COMMENT
read -p "Please enter the initial password for the new user to use: " INITIAL_PASSWORD

# Creating a new user
useradd -c "${COMMENT}" -m ${NEW_USERNAME}

if [[ "${?}" != 0 ]]
then
    echo "Oops, something went wrong and the new user WAS NOT created."
    exit 1
fi

# Set the password for user
echo ${INITIAL_PASSWORD} | passwd --stdin ${NEW_USERNAME}

# Force password change on first login
passwd -e ${NEW_USERNAME}

# Print output: username, password and hostname.
echo
echo "-----------------------------------------"
echo "The account is successfully created!"
echo "Username: ${NEW_USERNAME}"
echo "Password: ${INITIAL_PASSWORD}"
echo "Created By (Host): ${HOSTNAME}"
