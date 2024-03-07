#!/bin/bash

git checkout AUTO-UPDATE-DEPENDENCIES

mvn versions:update-properties

# Configure git user email and name
git config --global user.email "${USER_EMAIL}"
git config --global user.name "${USER_NAME}"

git commit -am "Automated versions:update-properties"
git push origin

curl -L -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${_WRITE_PR}" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/WJ-van-Hoek/parent-pom/pulls -d '{"title":"AUTO-PR: update properties","head":"AUTO-UPDATE-DEPENDENCIES","base":"master"}'

