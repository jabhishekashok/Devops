variable "names" {
  type = object({
    rgname  = string
    aksname = string
  })
  default = {
    rgname  = "testrg"
    aksname = "testaks"
  }

}

variable "rglocation" {
  type    = string
  default = "eastus"
}