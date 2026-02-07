#!/bin/bash

user=$(id -u)
log_folder="/var/log/fend-logs"
log_file="/var/log/fend-logs/$0.log"
SCRIPT_DIR=$PWD
sourcedirectory=$1
destinationdirectory=$2
numberofdays=${3:-14}

if [ $user -ne 0 ]; then
    echo "please run as sudo user / root user"
   exit 1

fi
mkdir -p $log_folder

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