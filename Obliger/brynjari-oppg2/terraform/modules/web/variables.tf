variable "instance_name" {
  type = string
}
variable "location" {
  type = string
}
variable "rg_name" {
  type = string
}
variable "repo_url" {
  type = string
  default = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
}
variable "branch" {
  type = string
  default = "main"
}
variable "storage_account_details" {
  type = object({
    access_key = string
    account_name = string
    share_name = string
    type = string
  })
}
variable "db_connection_string" {
  type = object({
    db_name = string
    type = string
    value = string
  })
}