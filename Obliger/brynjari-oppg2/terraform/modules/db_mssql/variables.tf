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
variable "administrator_creds" {
  sensitive = true
  type = object({
    username = string
    password = string
  })
  description = "Administrator login credentials. May be best practice to use KV."
}
# DB conf, these are mapped with each other
variable "max_size_gb" {
  type        = list(number)
  default     = 2
  description = "List of database maximum sizes"
}
variable "sku_name" {
  type        = list(string)
  default     = "S0"
  description = "list of Sku names used for DB"
}
variable "db_names" {
  type        = list(string)
  description = "List of databases"
}
variable "common_tags" {
  type = object({
    project      = string
    owner        = string
    billing_code = string
  })
}