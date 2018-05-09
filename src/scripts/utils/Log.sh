#!/bin/bash

# Time format for messages and logs
TIME=`date '+%d/%m/%Y %H:%M:%S'`

# PACKAGE_NAME variable is needed for creating log entries
PACKAGE_NAME=""

# override this variable each time you want to add log entry 
MESSAGE=""



# pass MESSAGE variable as argument of this function, example:
# echo_message $MESSAGE
# it will print colored light bold green message in console

echo_message() {

    echo -e ${lbGREEN}$@${NC}

}

echo_message_warning() {

    echo -e ${lbYELLOW}$@${NC}

}

echo_message_error() {

    echo -e ${lbRED}$@${NC}

}

first_run_log() {

    touch $MENTHOL_LOG_PATH
    MESSAGE="FIRST RUN"
    log_entry

}

log_entry() {

    echo "$TIME - $MESSAGE" >> $MENTHOL_LOG_PATH

}

log_entry_warning() {

    echo "$TIME - [ERROR] - $MESSAGE_WARNING" | tee $MENTHOL_LOG_PATH $MENTHOL_LOG_WARNINGS_PATH

}

    #try to pass file name as argument of function
    # Control files will be used to check if certain operation has been performed - they will be created after some 
    # operations has been performed.
    # TODO consider using log entries to do the same things.
control_file() {    
    touch ~/.menthol/log/control_files/"$FILE_NAME"
}