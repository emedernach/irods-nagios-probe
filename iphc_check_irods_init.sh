#!/bin/bash

##############################################################################  
#                                                                               
# Name      : iphc_check_irods_init.sh 
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


check_init() {
# iinit must be done before invoking tests.

    [ -d ~/.irods ] || ( echo Directory ~/.irods does not exist; exit $STATE_CRITICAL )
    [ -f ~/.irods/.irodsEnv ] || ( echo File ~/.irods/.irodsEnv does not exist; exit $STATE_CRITICAL )
    [ -f ~/.irods/.irodsA ] || ( echo File ~/.irods/.irodsA does not exist; exit $STATE_CRITICAL ) 
    echo All init files present
}

check_init
exit $STATE_OK

