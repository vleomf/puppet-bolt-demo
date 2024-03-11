#!/bin/bash
read -r -d '' params
reason=$(echo $params|jq -r '.reason')
reason=${reason:-unknown}


function task_response() {
    # Allow access to global variable
    global $reason            

    # JSON Response
    jq -n \
    --arg reason "$reason"\
    --arg status "false"\
    --arg msg "This is the error response(from json)"\
    '{reason:$reason, status:$status, msg:$msg}'
}

task_response
exit 1