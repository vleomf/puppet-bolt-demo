#!/bin/bash
read -r -d '' params
name=$(echo $params|jq -r '.name')
name=${name:-World}


function task_response() {
    # Allow access to global variable
    global $name            

    # JSON Response
    jq -n \
    --arg name "$name"\
    --arg status "ok"\
    --arg msg "Hello $name"\
    '{name:$name, status:$status, msg:$msg}'
}

task_response
exit 0