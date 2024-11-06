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
variable "common_tags" {
  type = object({
    project      = string
    owner        = string
    billing_code = string
  })
}
variable "virtual_network_id" {
  type = string
  description = "The ID of the Virtual Network within which the Backend Address Pool should exist"
}
variable "applications" {
  type = list(string)
  description = "names of the applications within the backend pool of the LB"
}