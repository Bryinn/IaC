variable "location" {
  type = string
  description = "location of datacenter used to host the recources"
}
variable "company" {
  type = string
  description = "Name of company"
}
variable "project" {
  type = string
  description = "Name of the current project"
}
variable "billing_code" {
  type = string
  description = "Billing code of project"
}
variable "project_owner" {
  type = string
  description = "Owner of the project"
}
variable "environment" {
  type = string
  description = "Tags common for the project"

  validation {
    condition     = contains(["prod", "test"], var.environment)
    error_message = "Valid values for var: test_variable are (prod, test)."
  } 
}
variable "replication_type" {
  type = string
  description = "Replication type for Storage accounts (LRS, ZRS, GRS, RA-GRS, GZRS, RA-GZRS)"

  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "RA-GRS", "GZRS", "RA-GZRS"], var.replication_type)
    error_message = "Valid values for var: replication_type are (LRS, ZRS, GRS, RA-GRS, GZRS, RA-GZRS)."
  } 
}
variable "instances_by_region" {
  type = list(string)
  description = "Number of instances per zone geological zone"

  validation {
    condition     = contains(["euw", "eun", "nor", "asia"], var.instances_by_region)
    error_message = "Valid values for var: instances_by_region are (euw, eun, nor, asia)."
  } 
}