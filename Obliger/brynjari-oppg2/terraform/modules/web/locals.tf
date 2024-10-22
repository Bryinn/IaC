locals {
  workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  sp_name = "${var.instance_name}-serviceplan-${local.workspace_suffix}"
  webapp_name = "${var.instance_name}-web-${local.workspace_suffix}"
  
}