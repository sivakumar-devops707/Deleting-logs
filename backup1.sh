#!/bin/bash

user=$(id -u)
log_folder="/var/log/backup-logs"
log_file="/var/log/backup-logs/$0.log"
SCRIPT_DIR=$PWD
sourcedirectory=$1
destinationdirectory=$2
numberofdays=${3:-14}

if [ $user -ne 0 ]; then
    echo "please run as sudo user / root user"
   exit 1

fi
mkdir -p $log_folder


log(){
    echo "$(date "+%y %m %d %h %m %s") | $1" |tee -a $log_file
}
usage(){
    echo "user inputs is mandatory sourcedirectory and destination directory and +14 days"
    exit 1
}

if [ $# -lt 2 ]; then
   usage
fi

if [ ! -d $sourcedirectory ];  then
   echo "this source directory $sourcedirectory is not exist"
   exit 1
fi 

if [ ! -d $destinationdirectory ];  then
    echo "this destination directory $destinationdirectory is not exist"
    exit 1
fi
findfiles=$(find $sourcedirectory -name "*.log" -type f -mtime +$numberofdays)

log "backup started.."
log "sorce directory : $sourcedirectory"
log "destination directory: $destinationdirectory"
log "days: $numberofdays"

if [ -z "${findfiles}" ]; then

    log "no files to archive....Skipping"
    exit 1
else
    log "files find  to archive....$findfiles"

    timestampt=$(date "+%F %h-%m-%s")
    zip_file_name="$destinationdirectory/app.logs-$timestampt.tar.gz"
    echo "archive name : $zip_file_name"
    find $sourcedirectory -name "*.log" -type f -mtime +$numberofdays | tar -zcvf $zip_file_name

   if [ -f $zip_file_name ]; then
        log "archiving is success.."
        while IFS= read -r filepath; do
         log "Deleting file: $filepath"
         rm -f "$file"
         log "deleted the file: $filepath "
        done <<< $findfiles

    else
        log "archiving is failure.."
        exit 1
    fi    
fi

