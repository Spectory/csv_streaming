#!/bin/bash

# Runs server& client unit tests, generating coverage reports.
#
# prerequirements:
#   - Rspec installed (its listed in the Gemfile, just run `bundle install`)
#   - karma installed (its listed in the package.json, just run `npm install`)
#
# Useage example:
#   ./scripts/generate_coverage_reports.sh

GREEN='\033[0;32m'
NO_COLOR='\033[0m'

COVERAGE=true ./bin/rspec
npm run test

printf "${GREEN}*******************************************************************************\n"
printf "Server Reports generated at coverage/index.html\n"
printf "Client Reports generated at coverage/karma/PhantomJS 2.1.1/javascripts/index.html\n"
printf "*******************************************************************************${NO_COLOR}\n"
