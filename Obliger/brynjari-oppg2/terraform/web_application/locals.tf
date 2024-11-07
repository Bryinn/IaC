locals {
  workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  common_instance_name = "webshop"
  location             = "West Europe"
  common_tags = {
    project      = "website"
    owner        = "brynjari"
    billing_code = "abc123457test${local.workspace_suffix}"
  }
  expiration_date = "2026-12-31T00:00:00Z"




  rg_name = "${local.common_instance_name}-${local.workspace_suffix}"

}