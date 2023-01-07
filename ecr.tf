resource "aws_ecr_repository" "nuvuli_agent" {
  name                 = "nuvuli-agent"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
