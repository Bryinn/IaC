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
variable "dns_servers" {
  type        = list(string)
  description = "IP addresses of DNS servers for the network. Leave empty if irrelevant."
}
variable "address_space" {
  type        = list(string)
  description = "IP addresses of address spaces for the network."
}
variable "sub_address_space" {
  type        = list(list(string))
  description = "IP addresses of address spaces for the subnet. The key of the map will be an additional name on the resource. Every address space will be its own subnet."
}
variable "sub_address_space_names" {
  type        = list(string)
  description = "Names for the subnets"
}