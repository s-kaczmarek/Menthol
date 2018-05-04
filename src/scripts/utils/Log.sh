#!/bin/bash

# Time format for messages and logs
TIME=`date '+%d/%m/%Y %H:%M:%S'`
# PACKAGE_NAME variable is needed for creating log entries
PACKAGE_NAME=""
# override this variable each time you want to add log entry 
MESSAGE=""  # override this variable each time you want to add log entry  

first_run_log() {

    touch ~/.menthol/log/menthol.log
    MESSAGE="FIRST RUN"
    log_entry

}

log_entry() {

    echo "$TIME - $MESSAGE" >> ~/.menthol/log/menthol.log

}

log_entry_warning() {

    echo "$TIME - [ERROR] - $MESSAGE_WARNING" | tee ~/.menthol/log/menthol.log ~/.menthol/log/menthol.warnings.log

}

control_file() {    
    #try to pass file name as argument of function
    # Control files will be used to check if certain operation has been performed - they will be created after some operations has been performed.
    # TODO consider using log entries to do the same things.
    touch ~/.menthol/log/control_files/"$FILE_NAME"
}