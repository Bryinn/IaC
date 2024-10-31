locals {
  workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  name_conv = "${var.instance_name}_${local.workspace_suffix}"

}