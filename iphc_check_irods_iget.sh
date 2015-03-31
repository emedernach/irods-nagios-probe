#!/bin/bash

##############################################################################  
#                                                                               
# Name      : iphc_check_irods_iget.sh 
# Author    : Emmanuel Medernach
#                                                                               
# Parameters: --help                                                            
#             --version                                                         
##############################################################################  

HELP="This script is used by Nagios to check transfert of files"

# Initialisation                                                                
NVERSION=0.1
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

PROGNAME=`basename $0`
PWARNING=$1
PCRITICAL=$2

DIR=/tmp

print_usage() {
    echo "Usage: $PROGNAME --help"
    echo "Usage: $PROGNAME --version"
}

print_help() {
    echo "Command : $PROGNAME"
    echo $HELP
    echo
    echo "Usage: $PROGNAME [-R <resource>] -d <destination>"
}

get_file() {
    
    RESOURCEOPTION="-R $RESOURCE"

    if [ -n "$DESTINATION" ]
    then
        DESTINATIONOPTION="-f $DESTINATION/DATE.$RESOURCE"
    else
        DESTINATIONOPTION="-f DATE.$RESOURCE"
    fi

    iget $RESOURCEOPTION $DESTINATIONOPTION $FILE.iget 2>&1 || exit $STATE_CRITICAL

}

DESTINATION=""
RESOURCE=""

# Parse the arguments                                                           
while [ -n "$1" ]; do
    case "$1" in
        --help)
            print_help
            exit $STATE_OK
            ;;
        -h)
            print_help
            exit $STATE_OK
            ;;
        --version)
            echo "Version: $NVERSION"
            exit $STATE_OK
            ;;
        -V)
            echo "Version: $NVERSION"
            exit $STATE_OK
            ;;
        -R)
            RESOURCE=$2
            shift
            ;;
        -d)
            DESTINATION=$2
            shift
            ;;
        *)
            echo "Unknown argument: $1"
            print_usage
            exit $STATE_UNKNOWN
            ;;
    esac
    shift
done

if [ -z $RESOURCE ]
then
    echo "Resource option not set: -R <resource>"
    exit $STATE_WARNING
fi

FILE="$DIR/DATE.$RESOURCE"

get_file
diff $FILE $FILE.iget > /dev/null
if [ $? -eq 0 ]; then
    echo Ok
    exit $STATE_OK
else
    echo Files are different
    exit $STATE_WARNING
fi



