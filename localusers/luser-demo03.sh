#!/bin/bash

# Display the UID and username of the user executing this script.
# Display if the user is the vagrant user or not.


# Display the UID.
echo "${UID}"

# Only display if the UID does NOT match 1000.
UID_TO_TEST_FOR='1000'
if [[ "${UID}" != ${UID_TO_TEST_FOR} ]]
then
    echo "Your UID does not match ${UID_TO_TEST_FOR}"
    exit 1  # exits with a non-zero status. A zero-status means that the program exits successfully.
fi

# Display the username.
USER_NAME=$(id -un)
echo "Your username is ${USER_NAME}."

# Test if the command succeeded.
if [[ "${?}" != 0 ]]  # ${?} catches the exit status of the last executed command
then
    echo 'The id command did not execute successfully.'
    exit 1
fi

# You can use a string test conditional.
USER_NAME_TO_TEST_FOR='vagrant'
if [[ "${USER_NAME}" = "${USER_NAME_TO_TEST_FOR}" ]]
then
    echo "Your username matches ${USER_NAME_TO_TEST_FOR}."
fi

# Test for != (not equal) for the string.
if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST_FOR}" ]]
then
    echo "Your username does not match ${USER_NAME_TO_TEST_FOR}."
    exit 1
fi

exit 0