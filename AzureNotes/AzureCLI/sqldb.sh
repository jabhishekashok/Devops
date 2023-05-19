#!/bin/bash

echo "check if RG exists"

RG_EXISTS=$(az group exists -n mysqlrg)

if [[ $RG_EXISTS ]]; then 
    echo "RG ${RG_EXISTS} exists"
else
    # Create an Azure Database for MySQL server
    az group create --name mysqlrg --location westus
    echo "RG named mysqlrg created"
fi

#exit 0

# Create an Azure Database for MySQL server
echo "creating server named azcliDBsvr"



az sql server create --name 'azcliDBsvr' \
--resource-group 'mysqlrg' \
--location 'westus' \
--admin-user 'qtdevops' \
--admin-password 'Root@root'

echo " Server named mydemoserver created"

exit 0

az mysql server create --resource-group mysqlrg \
--name mydemoserver1 \
--location westus \
--admin-user qtdevops \
--admin-password Rootroot 

echo " Server named mydemoserver created"


