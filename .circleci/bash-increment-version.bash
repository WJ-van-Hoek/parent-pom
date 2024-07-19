#!/bin/bash

# Source the bash-increment-version-function.sh script
source ./.circleci/bash-increment-version-function.bash > /dev/null

# Get the current version using Maven
CURRENT_VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

# Split the current version into major, minor, and subversion parts
split_version "${CURRENT_VERSION}"

# Increment the version using the split parts
NEXT_VERSION=$(increment_minor_subversion "${major}" "${minor}" "${subversion}")
echo "${NEXT_VERSION}"

# Set the new version using Maven
mvn versions:set -DnewVersion="${NEXT_VERSION}"

# Configure git user email and name
git config --global user.email "${USER_EMAIL}"
git config --global user.name "${USER_NAME}"

# Commit the version change
git commit -am "Bump version to ${NEXT_VERSION} [ci skip]"

# Push the changes to the remote repository
git push origin master

