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

echo "entered args => $1"

if [[ $# == 0 ]]; then
    echo "format for arguments is => resourcegroup state"
    echo "for default values => pass 'default' as argument"
    exit
elif [[ $1 == 'default' ]]; then
    RESOURCE_GROUP='Docker'
    DESIREDSTATE='Running'
    echo "assigning default values"
else
    C=1
    while (( $# ))
    do
        echo "count $C"
        if [[ $1 == "resourcegroup" ]]; then
            RESOURCE_GROUP=$(assign_default_if_empty $2 'Docker')
        elif [[ $1 == "state" ]]; then
            DESIREDSTATE=$2
        else
            echo "This script using resource group => ${RESOURCE_GROUP} ${CLUSTERNAME} ${DESIREDSTATE}"
            break
        fi
        shift
        shift
        C=$(($C+1))
    done
fi


VMNAME=$(az vm list -g $RESOURCE_GROUP --query "[0].name" --output tsv)

echo " name of the VM is $VMNAME"

VMSTATE=$(az vm show -g $RESOURCE_GROUP -n $VMNAME -d --query "powerState" --output tsv)

echo "Current state of the VM $VMNAME is $VMSTATE"

if [[ $VMSTATE == 'VM stopped' ]]; then
    echo "Starting the VM $VMNAME in resource group ${RESOURCE_GROUP}"
    az vm start -g $RESOURCE_GROUP -n $VMNAME 
    VMSTATE=$(az vm show -g $RESOURCE_GROUP -n $VMNAME -d --query "powerState" --output tsv)
    echo "Current state of the VM $VMNAME is $VMSTATE"
elif [[ $VMSTATE == 'VM running' ]]; then
    echo "Starting the VM $VMNAME in resource group ${RESOURCE_GROUP}"
    az vm stop -g $RESOURCE_GROUP -n $VMNAME 
    VMSTATE=$(az vm show -g $RESOURCE_GROUP -n $VMNAME -d --query "powerState" --output tsv)
    echo "Current state of the VM $VMNAME is $VMSTATE"
fi
