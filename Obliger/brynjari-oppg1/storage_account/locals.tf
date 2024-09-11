locals {
    common_tags = {
    company = var.company
    project = "${var.project}-${var.company}"
    owner = var.project_owner
  }
  name_conv = "${var.project}_${rg_sa.name}"
}