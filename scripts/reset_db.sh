#!/bin/bash

# resets local DB
#
# args
#   seed - run seeds
#
# Usage Example:
#   ./scripts/reset_db.sh
#   ./scripts/reset_db.sh seed
#

set -e

GREEN='\033[0;32m'
NO_COLOR='\033[0m'

printf "${GREEN}dropping local db...${NO_COLOR}\n"
./bin/rake db:drop
printf "${GREEN}creating local db...${NO_COLOR}\n"
./bin/rake db:create
printf "${GREEN}migrating...${NO_COLOR}\n"
./bin/rake db:migrate
RAILS_ENV=test ./bin/rake db:migrate

if [ "$1" = "seed" ]
then
  printf "${GREEN}seeding...${NO_COLOR}\n"
  ./bin/rake db:seed
fi