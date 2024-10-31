locals {
  workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  sa_name   = "${var.sa_name}${var.instance_name}${local.workspace_suffix}"
  sc_name   = "sc_${var.instance_name}_${local.workspace_suffix}"
  blob_name = "blob_${var.instance_name}_${local.workspace_suffix}"
}