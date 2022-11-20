#!/bin/bash

############################################################################################
# HELP
############################################################################################
Help()
{
  # Display Help.
  echo "Creates zip archive backup from specified directory to specified backup directory."
  echo
  echo "Syntax: backup_files.sh [-d] [-b]"
  echo "options:"
  echo "-d    Specifies directory to be backuped."
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
  zip -r "${backupDirectory}/backup.zip" $directory
  echo "Done.";
}

############################################################################################
# MAIN
############################################################################################

while getopts d:b:h flag
do
  case "${flag}" in
    d) directory=${OPTARG};;
    b) backupDirectory=${OPTARG};;
    h) Help
  esac
done
Execute
