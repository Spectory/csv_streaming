#!/bin/bash

# This script will copy the latest production DB backup to staging.
# args:
#   captrue - when set, heroku will capture a fresh production DB backup before processding.
#
# prerquerments:
#  User must have heroku acess to PROD & STG apps.
#
# Running examples:
#   ./scripts/copy_prod_db_to_stg.sh
#   ./scripts/copy_prod_db_to_stg.sh capture

set -e
GREEN='\033[0;32m'
NO_COLOR='\033[0m'
RED='\033[0;31m'

PROD=PROD_APP_NAME # found at Heroku
STG=STG_APP_NAME # found at Heroku
DEV=DEV_APP_NAME # found at Heroku

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

if [ "$2" = "capture" ]
then
  printf "${GREEN}capturing new db backup (${PROD})${NO_COLOR}\n"
  heroku pg:backups:capture -a $PROD
fi

printf "${GREEN} checking last production db backup URL${NO_COLOR}\n"
prod_backup_url=`heroku pg:backups:public-url -a ${PROD}`
printf "${GREEN} coping db to ${TARGET}, this may take a while${NO_COLOR}\n"
heroku pg:backups:restore $prod_backup_url DATABASE --app $TARGET --confirm $TARGET
