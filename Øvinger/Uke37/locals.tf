locals {
  common_tags = {
    company = var.company
    project = "${var.project}-${var.company}"
    owner = var.project_owner
  }
}