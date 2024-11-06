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
#variable "repo_url" {
#  type        = string
#  default     = "https://github.com/Azure-Samples/nodejs-docs-hello-world" # 
#  description = "Git repository URL used to import web server source code"
#}
#variable "branch" {
#  type        = string
#  default     = "main"
#  description = "The branch of the git repo that will be used for deployment"
#}
variable "storage_account_details" {
  type = object({
    access_key   = string
    account_name = string
    share_name   = string
    type         = string
  })
  sensitive   = true
  description = "Details from an external storage account to use for blob/file storage for the server. Type must be one of ['AzureBlob' 'AzureFiles']"
}
variable "db_name" {
  type = string
  description = "Name of the relevant database"
}
variable "db_type" {
  type = string
  description = "Type of the relevant databse"
}
variable "db_connection_string" {
  type = string
  description = "Connection string for the relevant databse"
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
  description = "The Network / subnet used for this application service"
}