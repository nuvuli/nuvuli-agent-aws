

resource "local_file" "schedule" {
  content = var.schedule
  filename = "${path.module}/schedule.json"
}


resource "null_resource" "schedule_api" {
  provisioner "local-exec" {

    command = "${path.module}/api.sh ${data.aws_caller_identity.current.account_id}"

    environment = {
      API_KEY = var.api_key
      API_ENDPOINT = var.api_endpoint
      TENANT_ID = var.tenant_id
      ACCOUNT_ID = var.account_id
      SCHEDULE_NAME = var.schedule_name
      MATCHING_TAGS = var.matching_tags
      SCHEDULE_PAUSED = var.paused
    }
  }

  triggers = {
    api_key = var.api_key
    api_endpoint = var.api_endpoint
    tenant_id = var.tenant_id
    account_id = var.account_id
    schedule_name = var.schedule_name
    matching_tags = var.matching_tags
    paused = var.paused
  }

  depends_on = [
    local_file.schedule,
    module.nuvuli_agent_lambda
  ]
}
