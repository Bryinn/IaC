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
