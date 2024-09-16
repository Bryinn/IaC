variable "location" {
  type = string
  description = "location of datacenter used to host the recources"
}
variable common_tags {
  type = object({
      company = string
      project = string
      owner = string
      billing_code = string
      environment = string
  })
}
variable name_conv {
  type = string
  description = "Naming convention used in all resources in this module"
}
variable "resource_name" {
  type = string
  description = "A name for the resource to be given along with other details. This is to distinguish this resource from other resources created. Keep the name relevant for it's purpose."
}
variable "dns_servers" {
  type = list(string)
  description = "IP addresses of DNS servers for the network. Leave empty if irrelevant."
}
variable "address_space" {
  type = list(string)
  description = "IP addresses of address spaces for the network."
}
variable "sub_address_space" {
  type = list(list(string))
  description = "IP addresses of address spaces for the subnet. The key of the map will be an additional name on the resource. Every address space will be its own subnet."
}
variable "sub_address_space_names" {
  type = list(string)
  description = "Names for the subnets"
}