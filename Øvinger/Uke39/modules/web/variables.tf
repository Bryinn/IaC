variable "rg_name" {
  type = string
  default = "rg-bry-test"
}
variable "location" {
  type = string
}
variable "sa_name" {
  type = string
  default = "sabry"
}
variable "source_content" {
  type = string
  default = "<h1>Made with Terraform<h1/>"
}
variable "index_document" {
  type = string
  default = "index.html"
}