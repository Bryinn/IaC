locals {
  workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  name_conv = "${var.instance_name}-${local.workspace_suffix}"
  sa_name   = "sa${var.instance_name}${local.workspace_suffix}"
}