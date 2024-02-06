variable "prefix" {
  type    = string
  default = "RGM"
}

variable "rglocation" {
  type    = string
  default = "northeurope"
}


variable "names" {
  type = object({
    rgname  = string
    aksname = string
    acrname = string
    azdiskrg = string
    azdiskname = string
    postgresazdiskrg = string
    postgresazdiskname = string
  })
  default = {
    rgname  = "AksAcrRG"
    aksname = "LuxRGMProjectAks"
    acrname = "LuxRGMProjectAcr"
    azdiskname = "myAKSDisk"
    azdiskrg = "LUXRGM_TFStateFiles"
    postgresazdiskrg = "LUXRGM_TFStateFiles"
    postgresazdiskname = "AKS-Postgres-Keycloak"
  }
}

variable "k8sdetails" {
  type = object({
    cluster_name   = string
    dns_prefix     = string
    agent_count    = string
    admin_username = string
    ssh_public_key = string
    nodepool_name  = string
    vm_size        = string
  })

  default = {
    cluster_name   = "RGM_K8s"
    dns_prefix     = "AKSdns"
    agent_count    = "2"
    admin_username = "RGMUser"
    ssh_public_key = "~/.ssh/id_rsa.pub"
    nodepool_name  = "rgmpool1"
    vm_size        = "Standard_B4ms"

  }

}


# The following two variable declarations are placeholder references.
# Set the values for these variable in terraform.tfvars
variable "aks_service_principal_app_id" {
  default = ""
}

variable "aks_service_principal_client_secret" {
  default = ""
}

# /Placeholder

variable "client_secret" {
  type    = string
  default = "AyP8Q~W4rxCZuVlslGy.f.C_6EHQurkZzfV0Fckk"
}