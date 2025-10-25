terraform {
  required_version = ">= 1.13.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, ~> 6.2.0"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = ">= 1.0.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.6"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
    opensearch = {
      source  = "opensearch-project/opensearch"
      version = ">= 2.2.0"
    }
  }
}
