locals {
  workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  instance_name = "${var.instance_name}-${local.workspace_suffix}"
  project       = var.common_tags.project
  owner         = var.common_tags.owner
  billing_code  = var.common_tags.billing_code
}