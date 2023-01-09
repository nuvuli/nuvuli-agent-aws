
resource "local_file" "schedule" {
  content = var.schedule
  filename = "${path.module}/schedule.json"
}


#resource "null_resource" "schedule_api" {
#  provisioner "local-exec" {
#    command = "${path.module}/api.sh ${data.aws_caller_identity.current.account_id}"
#
#    environment = {
#      API_KEY = var.api_key
#      API_URL = var.api_url
#      TENANT_ID = var.tenant_id
#      ACCOUNT_ID = var.account_id
#      SCHEDULE_NAME = var.schedule_name
#      MATCHING_TAGS = var.matching_tags
#      SCHEDULE_PAUSED = var.paused
#    }
#  }
#
#
#  depends_on = [
#    local_file.schedule,
#    module.nuvuli_agent_lambda
#  ]
#}
