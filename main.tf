
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  repository_name = "${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com/nuvuli-agent"
}


module "nuvuli_agent_lambda" {
  source = "terraform-aws-modules/lambda/aws"

  version = "3.2.1"

  function_name = "nuvuli-agent"
  description   = "Nuvuli Cloud Agent"

  create_package = false

  image_uri    = "${local.repository_name}@${data.aws_ecr_image.nuvuli_agent_image.id}"
  package_type = "Image"

  publish = true

  create_role = false
  lambda_role = aws_iam_role.nuvuli_agent.arn
  create_current_version_allowed_triggers = true

  attach_network_policy = true
  attach_cloudwatch_logs_policy = true
  cloudwatch_logs_retention_in_days = 60

  timeout = 600

  depends_on = [
    aws_iam_role.nuvuli_agent,
    null_resource.image_handler
  ]

  environment_variables = {
    API = "${var.api_endpoint}${var.api_bootstrap_path}"
    KEY = var.api_key
    TENANT_ID = var.tenant_id
    SCHEDULE_ID = var.schedule_id
    ACCOUNT_ID = var.account_id
  }
}


# schedule calls to lambda
resource "aws_cloudwatch_event_rule" "nuvuli_agent_lambda_every_15" {
  name                = "nuvuli-agent-lambda-every-15"
  description         = "Fires every 15 minutes"
  schedule_expression = "rate(15 minutes)"
}

# Trigger our lambda based on the schedule
resource "aws_cloudwatch_event_target" "trigger_nuvuli_agent_lambda_on_schedule" {
  rule      = aws_cloudwatch_event_rule.nuvuli_agent_lambda_every_15.name
  target_id = "lambda"
  arn       = module.nuvuli_agent_lambda.lambda_function_arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_split_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.nuvuli_agent_lambda.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.nuvuli_agent_lambda_every_15.arn
}
