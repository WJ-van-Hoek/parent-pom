#!/bin/bash

increment_version() {
    awk -F'.' '{
        if ($2 >= 9 && $3 >= 9) {
            print $1+1".0.0"
        } else if ($2 >= 9) {
            print $1+1".0."$3
        } else if ($3 >= 9) {
            print $1"."$2+1".0"
        } else {
            print $1"."$2"."$3+1
        }
    }'
}

CURRENT_VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)
NEXT_VERSION=$(echo "${CURRENT_VERSION}" | increment_version_using_awk)
mvn versions:set -DnewVersion="${NEXT_VERSION}"

git config --global user.email "${USER_EMAIL}"
git config --global user.name "${USER_NAME}"
git commit -am "Bump version to ${NEXT_VERSION} [ci skip]"
git push origin master
