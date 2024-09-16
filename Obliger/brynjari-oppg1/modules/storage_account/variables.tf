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
variable "project" {
  type = string
  description = "project name"
}
variable name_conv {
  type = string
  description = "Naming convention used in all resources in this module"
}
variable "resource_name" {
  type = string
  description = "A name for the resource to be given along with other details. This is to distinguish this resource from other resources created. Keep the name relevant for it's purpose."
}
variable "replication_type" {
  type = string
  description = "Replication type for Storage accounts (LRS, ZRS, GRS, RA-GRS, GZRS, RA-GZRS)"

  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "RA-GRS", "GZRS", "RA-GZRS"], var.replication_type)
    error_message = "Valid values for var: replication_type are (LRS, ZRS, GRS, RA-GRS, GZRS, RA-GZRS)."
  } 
}
variable "sa_instances" {
  type = number
  description = "Number of instances of the storage account."
}
variable sc_access_type {
  type = string
  description = "Type of storage containers that will be created for every storage account(private, blob, container)."

  validation {
    condition     = contains(["private", "blob", "container"], var.sc_access_type)
    error_message = "Valid values for var: sc_access_type are (private, blob, container)."
  } 
}

