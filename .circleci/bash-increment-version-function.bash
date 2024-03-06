#!/bin/bash

# Function to split a version string into major, minor, and subversion parts
split_version() {
    local version="${1}"
    IFS='.' read -r major minor subversion <<< "${version}"
}

# Function to increment the version
increment_version() {
    local major_version="$1"
    local minor_version="$2"
    local minor_subversion="$3"

    local version

    version=$(awk -v minor_subversion="${minor_subversion}" -v minor_version="${minor_version}" -v major_version="${major_version}" -F'.' '
        BEGIN {
            if (minor_version >= 9 && minor_subversion >= 9) {
                version = major_version + 1 ".0.0"
            } else if (minor_version >= 9) {
                version = major_version + 1 ".0." minor_subversion
            } else if (minor_subversion >= 9) {
                version = major_version "." minor_version + 1 ".0"
            } else {
                version = major_version "." minor_version "." minor_subversion + 1
            }
            print version
        }'
    )

    echo "${version}"
}

# Example usage
split_version "${1}"
increment_version "${major}" "${minor}" "${subversion}"


