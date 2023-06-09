### create resource group

'az group create -l westus -n k8srg'

### create K8s cluster:

'az aks create -g k8srg -n K8sCluster --node-count 1'

### attach Azure Key Vault

`az aks enable-addons --addons azure-keyvault-secrets-provider --name K8sCluster --resource-group k8srg`

`az keyvault secret set --vault-name K8skeyvaultqtpractice -n ExampleSecret --value MyAKSExampleSecret`

### connect aks cluster to azure private container registry

`az aks update -n K8sCluster -g k8srg --attach-acr abhicontainerregistryqtdevops`

### update nodepool labels in aks

`az aks nodepool update -g k8srg -n nodepool1 --cluster-name K8sCluster --labels purpose=testing --no-wait`

### create nodepool in aks with labels

`az aks nodepool add -g k8srg -n nodepool2 --cluster-name K8sCluster --node-count 1 --labels purpose=poc --no-wait`

### Stop/Start AKS cluster

'az aks stop --name K8sCluster --resource-group k8srg'

### Delete K8s Cluster

az aks delete --name K8sCluster --resource-group k8srg
