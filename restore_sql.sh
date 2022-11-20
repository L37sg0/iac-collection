#!/bin/bash

############################################################################################
# HELP
############################################################################################
Help()
{
  # Display Help.
  echo "Restores zip-archived sql dump into specified sql database docker container."
  echo
  echo "Syntax: backup_files.sh [-c] [-u] [-p] [-d] [-b]"
  echo "options:"
  echo "-c    Specifies docker sql container to be dumped."
  echo "-u    Specifies user with access to the database."
  echo "-p    Specifies password for the database."
  echo "-d    Specifies database name."
  echo "-b    Specifies backupDirectory for the backup being used. Should contain backup.zip file with single file in it."
  echo "-h    Prints this help message."
  echo
}

############################################################################################
# EXECUTE
############################################################################################
Execute()
{
  # Execute the script.
  unzip "${backupDirectory}/backup.zip" -p > "${backupDirectory}/backup.sql"
  cat "${backupDirectory}/backup.sql" | docker exec -i $containerName /usr/bin/mysql -u $username --password=$password $database
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
