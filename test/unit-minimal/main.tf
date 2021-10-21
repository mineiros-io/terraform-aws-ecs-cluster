# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MINIMAL FEATURES UNIT TEST
# This module tests a minimal set of features.
# The purpose is to test all defaults for optional arguments and just provide the required arguments.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

variable "aws_region" {
  description = "(Optional) The AWS region in which all resources will be created."
  type        = string
  default     = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # always test with exact version to catch unsupported blocks/arguments early
      # this should match the minimal version in versions.tf
      version = "3.57.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_string" "cluster_suffix" {
  length  = 4
  special = false
  upper   = false
}

module "test" {
  source = "../.."

  name = "ecs-test-cluster-${random_string.cluster_suffix.result}"

  # add only required arguments and no optional arguments
}

# outputs generate non-idempotent terraform plans so we disable them for now unless we need them.
# output "all" {
#   description = "All outputs of the module."
#   value       = module.test
# }
