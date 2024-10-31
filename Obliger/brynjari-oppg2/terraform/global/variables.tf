variable "location" {
  type        = string
  description = "Location of the resource by datacenter"
}
variable "rg_name" {
  type        = string
  description = "Resource group name used for all the resources in this module"
}
variable "common_instance_name" {
  type        = string
  description = "Descriptive name used in every module to describe the purpose or of which kind of stack the resource belongs to."
}
variable "common_tags" {
  type = object({
    project      = string
    owner        = string
    billing_code = string
  })
}
variable "expiration_date" {
  type        = string
  description = "Expiration date of access keyfor key vault"
}