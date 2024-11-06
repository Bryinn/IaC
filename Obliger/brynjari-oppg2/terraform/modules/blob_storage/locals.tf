locals {
  workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  sa_name   = "${var.sa_name}${var.instance_name}${local.workspace_suffix}"
  sc_name   = "sc${var.instance_name}${local.workspace_suffix}"
  blob_name = "blob-${var.instance_name}-${local.workspace_suffix}"
}