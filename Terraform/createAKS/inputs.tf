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

variable "prefix" {
  type = string
  default = "RGM"
}

variable "rglocation" {
  type    = string
  default = "northeurope"
}