
resource "aws_ecr_repository" "nuvuli_agent" {
  name                 = "nuvuli-agent"
  image_tag_mutability = "MUTABLE"

  force_delete = true

  image_scanning_configuration {
    scan_on_push = false
  }
}

data "aws_ecr_image" "nuvuli_agent_image" {
  repository_name = "nuvuli-agent"
  image_tag       = "latest"

  depends_on = [
    null_resource.image_handler
  ]
}

resource "null_resource" "image_handler" {
  provisioner "local-exec" {
    command = "${path.module}/image-handler.sh ${data.aws_caller_identity.current.account_id}"
  }

  depends_on = [
    aws_ecr_repository.nuvuli_agent
  ]
}
