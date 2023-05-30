### create resource group

'az group create -l westus -n k8srg'

### create K8s cluster:

'az aks create -g k8srg -n K8sCluster --node-count 1'

### Stop/Start AKS cluster

'az aks stop --name K8sCluster --resource-group k8srg'

### Delete K8s Cluster

az aks delete --name K8sCluster --resource-group k8srg
