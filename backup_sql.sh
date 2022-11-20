#!/bin/bash

############################################################################################
# HELP
############################################################################################
Help()
{
  # Display Help.
  echo "Creates zip archive backup from specified docker sql container using mysqldump."
  echo
  echo "Syntax: backup_files.sh [-c] [-u] [-p] [-d] [-b]"
  echo "options:"
  echo "-c    Specifies docker sql container to be dumped."
  echo "-u    Specifies user with access to the database."
  echo "-p    Specifies password for the database."
  echo "-d    Specifies database name."
  echo "-b    Specifies backupDirectory for the backup being saved."
  echo "-h    Prints this help message."
  echo
}

############################################################################################
# EXECUTE
############################################################################################
Execute()
{
  # Execute the script.
  docker exec $containerName /usr/bin/mysqldump -u $username --password=$password $database > "${backupDirectory}/backup.sql"
  zip -r "${backupDirectory}/backup.zip" "${backupDirectory}/backup.sql"
  echo "Done.";
}

############################################################################################
# MAIN
############################################################################################

while getopts c:u:p:d:b:h flag
do
  case "${flag}" in
    c) containerName=${OPTARG};;
    u) username=${OPTARG};;
    p) password=${OPTARG};;
    d) database=${OPTARG};;
    b) backupDirectory=${OPTARG};;
    h) Help
       exit;;
  esac
done
Execute
