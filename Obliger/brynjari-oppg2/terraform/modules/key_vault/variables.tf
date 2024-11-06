variable "common_tags" {
  type = object({
    project      = string
    owner        = string
    billing_code = string
  })
}
variable "location" {
  type        = string
  description = "Location of the resource by datacenter"
}
variable "rg_name" {
  type        = string
  description = "Resource group name used for all the resources in this module"
}
variable "instance_name" {
  type        = string
  description = "Naming used in all resources in this module"
}
variable "expiration_date" {
  type        = string
  description = "Expiration date of access key"
}
variable "secrets" {
  type = map(string)
}