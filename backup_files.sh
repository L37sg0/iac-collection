#!/bin/bash

############################################################################################
# HELP
############################################################################################
Help()
{
  # Display Help.
  echo "Creates zip archive backup from specified directory into ./backups/directory/files ."
  echo
  echo "Syntax: backup_files.sh [-d] [-h]"
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
  BACKUP_DIRECTORY="./backups/${PROJECT_NAME}"
  mkdir -p $BACKUP_DIRECTORY
  zip -r "${BACKUP_DIRECTORY}/file_backup_${DATE}.zip" $DIRECTORY
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
SCRIPT_TYPE="FILES_BACKUP"
Execute;
