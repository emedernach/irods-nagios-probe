#!/bin/bash

##############################################################################  
#                                                                               
# Name      : iphc_check_irods_connections.sh 
# Author    : Emmanuel Medernach
#                                                                               
# Parameters: --help                                                            
#             --version                                                         
##############################################################################  


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


number_of_connection() {
    ips | grep -v '^Server:' | wc -l
}

number_of_connection
exit $STATE_OK
