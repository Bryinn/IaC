variable "location" {
  type        = string
  description = "Location of the resource by datacenter"
  default = "West Europe"
}
variable "rg_name" {
  type        = string
  description = "Resource group name used for all the resources in this module"
  default = "webshop"
}
variable "common_instance_name" {
  type        = string
  description = "Descriptive name used in every module to describe the purpose or of which kind of stack the resource belongs to."
  default = "webshop"
}
variable "common_tags" {
  type = object({
    project      = string
    owner        = string
    billing_code = string
  })
  default = {
    billing_code = "abc123457test3"
    owner = "brynjari"
    project = "website"
  }
}
variable "expiration_date" {
  type        = string
  description = "Expiration date of access keyfor key vault"
  default = "2026-12-31T00:00:00Z"
}