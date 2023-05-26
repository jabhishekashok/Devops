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


if [[ $# == 0 ]]; then
    echo "format for arguments is => resourcegroup clustername nodecount nodepoolname"
    exit
fi


RESOURCEGROUP=$(assign_default_if_empty $1 'k8srg')
CLUSTERNAME=$(assign_default_if_empty $1 'MyK8sCluster')
NODECOUNT=$(assign_default_if_empty $1 '1')
NODEPOOLNAME=$(assign_default_if_empty $1 'nodepool1')

#filter the input arguments
while (( $# ))
do
    echo "count $C"
    if [[ $1 == "resourcegroup" ]]; then
        RESOURCEGROUP=$2
    elif [[ $1 == "clustername" ]]; then
        CLUSTERNAME=$2
    elif [[ $1 == "nodecount" ]]; then
        NODECOUNT=$2
    elif [[ $1 == "nodepoolname" ]]; then
        NODEPOOLNAME=$2
    else
        echo "This script using resource group => ${RESOURCEGROUP} ${CLUSTERNAME} ${NODECOUNT} ${NODEPOOLNAME} "
        break
        #exit
    fi
    shift
    shift
    C=$(($C+1))
done

NODEEXIST=$(az aks show --resource-group $RESOURCEGROUP --name $CLUSTERNAME --query "agentPoolProfiles[].[count]" --output tsv)

echo "Node count is => ${NODEEXIST} entered count => ${NODECOUNT}"

#exit 0

if [[ $NODEEXIST != $NODECOUNT ]]; then
    az aks scale --resource-group $RESOURCEGROUP --name $CLUSTERNAME --node-count $NODECOUNT --nodepool-name $NODEPOOLNAME
    NODEEXIST=$(az aks show --resource-group $RESOURCEGROUP --name $CLUSTERNAME --query "agentPoolProfiles[].[count]" --output tsv)
    echo "Latest Node count is => ${NODEEXIST}"
fi