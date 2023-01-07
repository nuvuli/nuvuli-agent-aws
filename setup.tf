
terraform {
  required_version = "= 1.1.3"

  required_providers {
    aws    = {
      source = "hashicorp/aws"
      version = "4.49.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }
}
