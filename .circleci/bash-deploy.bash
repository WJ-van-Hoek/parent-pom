#!/bin/bash

git checkout master
mvn deploy --settings ./.circleci/settings.xml