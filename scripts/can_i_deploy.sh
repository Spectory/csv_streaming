#!/bin/bash

# Verifies all basic deployment requirements are met.
#   - Unit tests pass
#   - Linters pass
# 
# Prerequiements:
#   - Rubocop installed (it is listed in Gemfile, just run `bundle install``)
#   - ESLlint installed (it is listed in package.json, just run `npm install``)
#
# Usage example:
#   - ./scripts/can_i_deploy.sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

./bin/rspec
exit_status=$?
if [ $exit_status -ne 0 ]
then
  printf "${RED} ******************************\n"
  printf "${RED} Server tests Failed!!! Please fix\n"
  printf "${RED} ******************************\n"
  exit $exit_status
else
  printf "${GREEN} ******************************\n"
  printf "${GREEN} Server tests passed!\n"
  printf "${GREEN} ******************************\n"
fi

npm test
exit_status=$?
if [ $exit_status -ne 0 ]
then
  printf "${RED} ******************************\n"
  printf "${RED} Client tests Failed!!! Please fix\n"
  printf "${RED} ******************************\n"
  exit $exit_status
else
  printf "${GREEN} ******************************\n"
  printf "${GREEN} Client tests passed!\n"
  printf "${GREEN} ******************************\n"
fi

./bin/rubocop --cache true
exit_status=$?
if [ $exit_status -ne 0 ]
then
  printf "${YELLOW} ******************************\n"
  printf "${YELLOW} Rubocop linting Failed!!! Please fix\n"
  printf "${YELLOW} ******************************\n"
  exit $exit_status
else
  printf "${GREEN} Rubocop linting passed!\n"
fi

./node_modules/.bin/eslint ./app/assets/javascripts
exit_status=$?
if [ $exit_status -ne 0 ]
then
  printf "${YELLOW} ******************************\n"
  printf "${YELLOW} Eslint Failed on ./app/assets/javascripts!!! Please fix\n"
  printf "${YELLOW} ******************************\n"
  exit $exit_status
fi
./node_modules/.bin/eslint ./spec/javascripts
exit_status=$?
if [ $exit_status -ne 0 ]
then
  printf "${YELLOW} ******************************\n"
  printf "${YELLOW} Eslint Failed on ./spec/javascripts!!! Please fix\n"
  printf "${YELLOW} ******************************\n"
  exit $exit_status
fi