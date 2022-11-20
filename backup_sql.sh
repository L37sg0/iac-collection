#!/bin/bash

############################################################################################
# HELP
############################################################################################
Help()
{
  # Display Help.
  echo "Creates zip archive backup from specified docker sql container using mysqldump."
  echo
  echo "Syntax: backup_sql.sh [-d]"
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
  source "${DIRECTORY}/.env"
  BACKUP_DIRECTORY="./backups/${PROJECT_NAME}"
  mkdir -p $BACKUP_DIRECTORY
  BACKUP_DUMP="${BACKUP_DIRECTORY}/sql_backup_${DATE}.sql"
  BACKUP_ZIP="${BACKUP_DIRECTORY}/sql_backup_${DATE}.zip"
  docker exec "${PROJECT_NAME}_db" /usr/bin/mysqldump -u $DB_USERNAME --password=$DB_PASSWORD $DB_DATABASE > $BACKUP_DUMP
  zip -r $BACKUP_ZIP $BACKUP_DUMP
  rm $BACKUP_DUMP
  if [ "$?" -eq 0 ]
  then
    curl --request POST $SLACK_HOOK -d 'payload={"text": "<!channel> Result of sql backup on '$PROJECT_NAME' is SUCCESS on '$DATE'"}'
  else
    curl --request POST $SLACK_HOOK -d 'payload={"text": "<!channel> Result of sql backup on '$PROJECT_NAME' is FAIL on '$DATE'"}'
  fi
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
DATE=`date +%Y_%m_%d`
Execute
