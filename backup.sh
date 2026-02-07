#!/bin/bash

log_folder=/home/ec2-user/app.log
log_file="$log_folder/$0.log"

if [ ! -d $log_folder ]; then
   echo "this folder $log_folder is not exist.."
   exit 1
fi
file_to_delete=$(find $log_folder -name "*.log" -type f -mtime +14) 

#echo "$file_to_delete"

while IFS= read -r filepath; do
    echo "Deleting file: $filepath"
   # rm "$file"
done <<< $file_to_delete
