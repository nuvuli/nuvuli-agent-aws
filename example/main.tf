
provider "aws" {
  region = "us-east-1"
}

module "nuvuli_agent" {
  source = "../"

  api_url = var.api_url
  api_key = var.api_key
  tenant_id = var.tenant_id
  schedule_id = var.schedule_id
  account_id = var.account_id
}
