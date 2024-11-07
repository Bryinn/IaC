locals {
  workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  rg_name = "${var.rg_name}-${local.workspace_suffix}"

}