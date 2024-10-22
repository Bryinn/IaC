locals {
  workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  lb_name = "${var.instance_name}-lb-${local.workspace_suffix}"
  
}