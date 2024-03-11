#!/bin/bash

node=${1:-test}
user=${2:-admin}
hash=$(echo -n "$user:$node" | md5sum | awk '{print $1}')
ssh-keygen -t rsa -f ".ssh/$hash"

ssh-copy-id -f "$user@$node"