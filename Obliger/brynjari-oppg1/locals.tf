locals {
  common_tags = {
    company = "${var.company}"
    project = "${var.project}-${var.company}"
    owner = "${var.project_owner}"
    billing_code = "${var.billing_code}"
    environment = "${var.environment}"
  }
  name_conv = lower("${var.project}_${var.environment}")
}