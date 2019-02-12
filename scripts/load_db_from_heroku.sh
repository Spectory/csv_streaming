#!/bin/bash

# Copys a DB backup from Heroku into localhost
#
# args
#   - dev/stg/prod - the remote DB you wish to copy.
#   - capture - create a fresh db backup.
#
# Usage Example:
#   ./script/load_db_from_heroku prod capture
#   ./script/load_db_from_heroku stg


# Exit if any subcommand fails
set -e
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NO_COLOR='\033[0m'

PROD=PROD_APP_NAME # found at Heroku
STG=STG_APP_NAME # found at Heroku
DEV=DEV_APP_NAME # found at Heroku
LOCAL_DB=LOCAL_DB_NAME # found at database.yml

if [ "$1" = "prod" ]
then
  TARGET=$PROD
fi

if [ "$1" = "stg" ]
then
  TARGET=$STG
fi
if [ "$1" = "dev" ]
then
  TARGET=$DEV
fi

if [ -z "$TARGET" ]
then
  printf "${RED}You must state dev or stg as first argument!${NO_COLOR}\n"
  exit
fi

printf "${YELLOW} ******************************\n"
printf "Make sure local db is not accessed by any thing (mix server, mix console, pgadmin3...)\n"
printf "${YELLOW} ******************************${NO_COLOR}\n"

if [ "$1" = "" ]
then
  printf "${RED}No remote name given. view avaiable remotes by running 'git remote'${NO_COLOR}\n"
  exit
fi

printf "${GREEN}dropping local db${NO_COLOR}\n"
./bin/rake db:drop
./bin/rake db:create

if [ "$2" = "capture" ]
then
  printf "${GREEN}capturing new db backup ($1)${NO_COLOR}\n"
  heroku pg:backups:capture -a $TARGET
fi

printf "${GREEN}Downloading backup${NO_COLOR}\n"
curl -o /tmp/latest.dump `heroku pg:backups:public-url -a $TARGET`

printf "${GREEN}loading backup into localhost (db is ${TARGET})${NO_COLOR}\n"
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d $LOCAL_DB /tmp/latest.dump
