locals {
  workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  connection_string_name = "${var.db_name}ConnectionString${local.workspace_suffix}"
  sp_name                = "${var.instance_name}-serviceplan-${local.workspace_suffix}"
  webapp_name            = "${var.instance_name}-web-${local.workspace_suffix}"
  abs_sa_name            = "${var.instance_name}${var.storage_account_details.account_name}${local.workspace_suffix}"
}