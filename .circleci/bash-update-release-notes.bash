#!/bin/bash

# Source the bash-increment-version-function.sh script
source ./.circleci/bash-increment-version-function.bash > /dev/null

update_release_notes() {
    local size="$1"
    local category="$2"
    local content="$3"
    
    CURRENT_VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)
    # Split the current version into major, minor, and subversion parts
    split_version "${CURRENT_VERSION}"

    # Increment the version using the split parts
    NEXT_VERSION=$(increment_minor_sub_version "${major}" "${minor}" "${subversion}")

    # Define the new line to add
    new_line="|${NEXT_VERSION}  |$(date +"%Y-%m-%d")  |${size}|${category}|${content} |"

    # Define the file to update
    file="README.md"

    # Find the line number of the header
    header_line_number=$(grep -n -m 1 "Release version" $file | cut -d ":" -f 1)

    # Increment the header line number to get the line number right under the header
    new_line_number=$((header_line_number + 2))

    # Insert the new line into the file
    sed -i "${new_line_number}i $new_line" $file
}
