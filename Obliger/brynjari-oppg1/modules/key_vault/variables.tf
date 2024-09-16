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
variable "sku_name" {
  type = string
  description = "(standard, permium)"
  default = "standard"
  validation {
      condition     = contains(["standard", "premium"], var.sku_name)
      error_message = "Valid values for var: sku_name are (standard, permium)."
  } 
}
variable "enabled_for_disk_encryption" {
    type = bool
    default = true
    description = "Disk encryption."
}
variable "soft_delete_retention_days" {
    type = number
    default = 14
    description = "Days data is kept after a soft delete of the resource in case of data being needed."
}
variable "purge_protection_enabled" {
    type = bool
    default = false
    description = "If true, block purge, if false, this resource can be wiped clean."
}
variable "key_name" {
  type = set(string)
  default = null
  description = "Set of names for the keys in the keyvault."
}
variable "key_type" {
  type = string
  default = null
  description = "Type of key generated for the keyvault."
}
variable "key_size" {
  type = number
  default = null
  description = "Size(strength) of key generated in the keyvault."
}
variable "key_ops" {
  type = list(string)
  default = null
  description = "Options for the keys generated(decrypt, encrypt, sign, unwrapKey, verify, wrapKey)."
    
  #validation {
  #    condition     = contains(["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"], var.key_ops)
  #    error_message = "Valid values for var: key_ops are (decrypt, encrypt, sign, unwrapKey, verify, wrapKey)."
  #} 
}
variable "secrets" {
  type = map(string)
  default = null
  description = "Username mapped to secrets in the keyvault."
}
 variable "sa_keys_as_secrets" {
  default = null
  type = list(string)
 }
  variable "sa_names" {
  default = null
  type = list(string)
 }
