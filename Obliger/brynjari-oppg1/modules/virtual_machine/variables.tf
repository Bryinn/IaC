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
variable "vm_names" {
  type = list(string)
  description = "A list of names for the vms to be given along with other details. This is to distinguish this resource from other resources created. Keep the name relevant for it's purpose."
}
variable "vm_sizes" {
  type = list(string)
  description = "Sizes for all the vms. The order is mapped to the names, correct order is significant."
}
variable "network_interface_ids" {
  type = list(string)
  description = "Network interfaces for all the vms. The order is mapped to the names, correct order is significant."
}
variable "secrets" {
  type = list(object({
    content_type = string,
    expiration_date = string,
    id = string,
    key_vault_id = string,
    not_before_date = string,
    name = string,
    resource_id = string,
    resource_versionless_id = string,
    tags = map(string),
    timeouts = map(string),
    value = string,
    version = string,
    versionless_id = string
  }))
}
