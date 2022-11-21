#!/bin/bash

############################################################################################
# HELP
############################################################################################
Help()
{
  # Display Help.
  echo "Creates zip archive backup from specified docker sql container using mysqldump."
  echo
  echo "Syntax: backup_sql.sh [-d] [-h]"
  echo "options:"
  echo "-d    Specifies directory of the project."
  echo "-h    Prints this help message."
  echo
}

############################################################################################
# EXECUTE
############################################################################################
Execute()
{
  # Execute the script.
  BACKUP_DIRECTORY="./backups/${PROJECT_NAME}"
  mkdir -p $BACKUP_DIRECTORY
  BACKUP_DUMP="${BACKUP_DIRECTORY}/sql_backup_${DATE}.sql"
  BACKUP_ZIP="${BACKUP_DIRECTORY}/sql_backup_${DATE}.zip"
  docker exec "${PROJECT_NAME}_db" /usr/bin/mysqldump -u $DB_USERNAME --password=$DB_PASSWORD $DB_DATABASE > $BACKUP_DUMP
  zip -r $BACKUP_ZIP $BACKUP_DUMP
  rm $BACKUP_DUMP
  NotifySlack
  echo "Done.";
}

############################################################################################
# MAIN
############################################################################################

while getopts d:h flag
do
  case "${flag}" in
    d) DIRECTORY=${OPTARG};;
    h) Help
       exit;;
  esac
done
source "${DIRECTORY}/.env"
source "notifications.lib"
DATE=`date +%Y_%m_%d`
SCRIPT_TYPE="SQL_BACKUP"
Execute
