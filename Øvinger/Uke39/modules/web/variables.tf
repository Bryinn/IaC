variable "rg_name" {
  type = string
  default = "rg-web"
}
variable "location" {
  type = string
}
variable "sa_name" {
  type = string
  default = "saweb"
}
variable "source_content" {
  type = string
  default = "<h1>Made with Terraform<h1/>"
}
variable "index_document" {
  type = string
  default = "index.html"
}