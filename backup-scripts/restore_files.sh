#!/bin/bash

############################################################################################
# HELP
############################################################################################
Help()
{
  # Display Help.
  echo "Restores zip archive to specified restore directory."
  echo
  echo "Syntax: backup_files.sh [-r] [-b]"
  echo "options:"
  echo "-r    Specifies directory to be restored."
  echo "-b    Specifies backupDirectory for the backup being used."
  echo "-h    Prints this help message."
  echo
}

############################################################################################
# EXECUTE
############################################################################################
Execute()
{
  # Execute the script.
  unzip "${backupDirectory}/backup.zip" -d $restoreDirectory
  echo "Done.";
}

############################################################################################
# MAIN
############################################################################################

while getopts r:b:h flag
do
  case "${flag}" in
    r) restoreDirectory=${OPTARG};;
    b) backupDirectory=${OPTARG};;
    h) Help
       exit;;
  esac
done
Execute
