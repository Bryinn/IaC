variable "location" {
  type = string
  description = "location of datacenter"
}
variable "company" {
  type = string
  description = "Name of company"
}
variable "project" {
  type = string
  description = "project name"
}
variable "billing_code" {
  type = string
  description = "Billing code of project"
}
variable "project_owner" {
  type = string
  description = "Owner of the project"
}
variable "vm_sizes" {
  type = list(string)
  description = "Aliases tied to actual VM size codes"
  default = [ "small", "medium", "large", "huge" ]
}
variable "regions" {
  type = list(string)
  description = "List of regions approved to host our recources"
}