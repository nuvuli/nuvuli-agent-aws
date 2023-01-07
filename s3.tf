locals {
  account_id = data.aws_caller_identity.current.account_id
  bucket_name = "nuvuli-agent-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket" "nuvuli_agent_bucket" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket_acl" "nuvuli_agent_bucket" {
  bucket = aws_s3_bucket.nuvuli_agent_bucket.bucket
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "nuvuli_agent_bucket" {
  bucket = aws_s3_bucket.nuvuli_agent_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
