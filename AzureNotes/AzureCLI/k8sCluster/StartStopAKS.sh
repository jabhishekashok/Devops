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
    echo "format for arguments is => resourcegroup clustername state"
    echo "for default values => pass 'default' as argument"
    exit
elif [[ $1 == 'default' ]]; then
    RESOURCE_GROUP='k8srg'
    CLUSTERNAME='MyK8sCluster'
    DESIREDSTATE='Running'
    echo "assigning default values"
else
    C=1
    while (( $# ))
    do
        echo "count $C"
        if [[ $1 == "resourcegroup" ]]; then
            RESOURCE_GROUP=$(assign_default_if_empty $2 'k8srg')
        elif [[ $1 == "clustername" ]]; then
            CLUSTERNAME=$(assign_default_if_empty $2 'MyK8sCluster')
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

#RESOURCE_GROUP=$(assign_default_if_empty $1 'k8srg')
#CLUSTERNAME=$(assign_default_if_empty $1 'MyK8sCluster')

echo "This script using resource group => ${RESOURCE_GROUP} ${CLUSTERNAME} ${DESIREDSTATE}"

echo "az aks show --name ${CLUSTERNAME} --resource-group ${RESOURCE_GROUP} --query "agentPoolProfiles[].[powerState][].code" --output tsv"
CLUSTERSTATE=$(az aks show --name ${CLUSTERNAME} --resource-group ${RESOURCE_GROUP} --query "agentPoolProfiles[].[powerState][].code" --output tsv)
echo "current state of instance => ${CLUSTERSTATE}"
#exit 0

if [[ $CLUSTERSTATE == 'Running' && $DESIREDSTATE == 'Stopped' ]]; then
    echo "stopping running instance --name ${CLUSTERNAME} --resource-group ${RESOURCE_GROUP}"
    az aks stop --name ${CLUSTERNAME} --resource-group ${RESOURCE_GROUP}
    CLUSTERSTATE=$(az aks show --name ${CLUSTERNAME} --resource-group ${RESOURCE_GROUP} --query "agentPoolProfiles[].[powerState][].code" --output tsv)
    echo "current state of instance => ${CLUSTERSTATE}"
elif [[ $CLUSTERSTATE == 'Stopped' && $DESIREDSTATE == 'Running' ]]; then
    echo "Starting running instance --name ${CLUSTERNAME} --resource-group ${RESOURCE_GROUP}"
    az aks start --name ${CLUSTERNAME} --resource-group ${RESOURCE_GROUP}
    CLUSTERSTATE=$(az aks show --name ${CLUSTERNAME} --resource-group ${RESOURCE_GROUP} --query "agentPoolProfiles[].[powerState][].code" --output tsv)
    echo "current state of instance => ${CLUSTERSTATE}"
fi


# Deleting the AKS cluster 
#az aks delete --name MyK8sCluster --resource-group k8srg --no-wait true --yes -y 