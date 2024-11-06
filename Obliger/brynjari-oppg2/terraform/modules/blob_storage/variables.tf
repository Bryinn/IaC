variable "sa_name" {
  type        = string
  description = "Non-final name of storage account"
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
variable "sa_account_tier" {
  type        = string
  default     = "Standard"
  description = "Account tier of the storage account"
}
variable "sa_account_replication" {
  type        = string
  default     = "LRS"
  description = "Replication type for SA"
}
variable "blob_storage_type" {
  type        = string
  default     = "Block"
  description = "Type of storage for the azure blob"
}
variable "sc_access_type" {
  type        = string
  default     = "private"
  description = "The access type for the storage container"
}
variable "common_tags" {
  type = object({
    project      = string
    owner        = string
    billing_code = string
  })
}