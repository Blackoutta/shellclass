#!/bin/bash
# The goal of this exercise is to create a shell script that adds users to the same Linux system as the script is executed on

# Enforces root privilege (must be root to create users)
if [[ "${UID}" != 0 ]]
then
    echo "You must be root to execute this script."
    exit 1
fi

# Check if the user supplies an account name. if not, then exit and provide a usage statement
if [[ "${#}" -lt 1 ]]
then
    echo "USAGE: ${0} ACCOUNT [COMMENT]..."
    echo "Create an account on the local system with the name of USER_NAME and a comments field of COMMENT."
    exit 1
fi

# Get the first argument as username
NEW_USERNAME="${1}"

# Chop off the first argument, leaving the rest of them as a comment
shift 

# Group the rest of the arguments as a single string, thus a comment
COMMENT="${@}"

# Generate a random 8-digits password
INITIAL_PASSWORD="$(date +%s%N | sha256sum | head -c8)"

# Create a new user
useradd -c "${COMMENT}" -m ${NEW_USERNAME}

# If, for some reason, the useradd command failed, notify the user and exit
if [[ "${?}" != 0 ]]
then
    echo "Oops, something went wrong and the new user WAS NOT created."
    exit 1
fi

# Set the password for user
echo ${INITIAL_PASSWORD} | passwd --stdin ${NEW_USERNAME}

# Check to see if passwd command succeeded
if [[ "${?}" -ne 0 ]]
then
    echo 'The password for the account could not be set.'
    exit 1
fi

# Force password change on first login
passwd -e ${NEW_USERNAME}

# Print output: username, password and hostname
echo
echo "-----------------------------------------"
echo "The account is successfully created!"
echo "Username: ${NEW_USERNAME}"
echo "Password: ${INITIAL_PASSWORD}"
echo "Created By (Host): ${HOSTNAME}"
echo "-----------------------------------------"
