#!/bin/bash

assign_default_if_empty() {
    value=$1
    default=$2
    if [[ -z $value ]]; then
        echo $default
    else
        echo $value
    fi
}
echo $#

#RESOURCE_GROUP=$(assign_default_if_empty $2 'Docker')
C=1
while (( $# ))
do
    echo "count $C"
    if [[ $1 == "--resource-group" ]]; then
        RESOURCE_GROUP=$2
    else
        echo "This script using resource group => ${RESOURCE_GROUP}"
        exit
    fi
    shift
    shift
    C=$(($C+1))
done

echo ${RESOURCE_GROUP}
az vm list -g ${RESOURCE_GROUP}

