#!/bin/bash

############################################################################################
# HELP
############################################################################################
Help()
{
  # Display Help.
  echo "Creates zip archive backup from specified directory into ./backups/directory/files ."
  echo
  echo "Syntax: backup_files.sh [-d]"
  echo "options:"
  echo "-d    Specifies directory to be backup-ed."
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
  zip -r "${BACKUP_DIRECTORY}/file_backup_${DATE}.zip" $DIRECTORY
  if [ "$?" -eq 0 ]
  then
    curl --request POST $SLACK_HOOK -d 'payload={"text": "<!channel> Result of files backup on '$PROJECT_NAME' is SUCCESS on '$DATE'"}'
  else
    curl --request POST $SLACK_HOOK -d 'payload={"text": "<!channel> Result of files backup on '$PROJECT_NAME' is FAIL on '$DATE'"}'
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
DATE=`date +%Y_%m_%d`;
Execute;
