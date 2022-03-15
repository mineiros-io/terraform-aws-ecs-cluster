header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-aws-ecs-cluster"

  badge "build" {
    image = "https://github.com/mineiros-io/terraform-aws-ecs-cluster/workflows/Tests/badge.svg"
    url   = "https://github.com/mineiros-io/terraform-aws-ecs-cluster/actions"
    text  = "Build Status"
  }

  badge "semver" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-aws-ecs-cluster.svg?label=latest&sort=semver"
    url   = "https://github.com/mineiros-io/terraform-aws-ecs-cluster/releases"
    text  = "GitHub tag (latest SemVer)"
  }

  badge "terraform" {
    image = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
    url   = "https://github.com/hashicorp/terraform/releases"
    text  = "Terraform Version"
  }

  badge "tf-aws-provider" {
    image = "https://img.shields.io/badge/AWS-3-F8991D.svg?logo=terraform"
    url   = "https://github.com/terraform-providers/terraform-provider-aws/releases"
    text  = "AWS Provider Version"
  }

  badge "slack" {
    image = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
    url   = "https://mineiros.io/slack"
    text  = "Join Slack"
  }
}

section {
  title   = "terraform-aws-ecs-cluster"
  toc     = true
  content = <<-END
    A [Terraform] module to create and manage an
    [Amazon ECS Cluster](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/clusters.html)
    on [Amazon Web Services (AWS)][aws].

    **_This module supports Terraform version 1
    and is compatible with the Terraform AWS Provider version 3.57.0**

    This module is part of our Infrastructure as Code (IaC) framework
    that enables our users and customers to easily deploy and manage reusable,
    secure, and production-grade cloud infrastructure.
  END

  section {
    title   = "Module Features"
    content = <<-END
      This module implements the following Terraform resources

      - `aws_ecs_cluster`
    END
  }

  section {
    title   = "Getting Started"
    content = <<-END
      Most common usage of the module:

      ```hcl
      module "terraform-aws-ecs-cluster" {
        source = "git@github.com:mineiros-io/terraform-aws-ecs-cluster.git?ref=v0.0.1"

        name = "name-of-cluster"
      }
      ```
    END
  }

  section {
    title   = "Module Argument Reference"
    content = <<-END
      See [variables.tf] and [examples/] for details and use-cases.
    END

    section {
      title = "Main Resource Configuration"

      variable "name" {
        required    = true
        type        = string
        description = <<-END
          Name of the cluster (up to 255 letters, numbers, hyphens, and
          underscores).
        END
      }

      variable "tags" {
        type        = map(string)
        default     = {}
        description = <<-END
          A map of tags to apply to all created resources.
        END
      }

      variable "enable_container_insights" {
        type        = bool
        default     = true
        description = <<-END
          Whether to use CloudWatch Container Insights to collect, aggregate,
          and summarize metrics and logs.
        END
      }

      variable "configuration" {
        type        = object(configuration)
        description = <<-END
          The execute command configuration for the cluster.
        END

        attribute "execute_command_configuration" {
          type        = object(execute_command_configuration)
          description = <<-END
            The details of the execute command configuration.
          END

          attribute "kms_key_id" {
            type        = string
            description = <<-END
              The AWS Key Management Service key ID to encrypt the data between
              the local client and the container.
            END
          }

          attribute "logging" {
            type        = string
            description = <<-END
              The log setting to use for redirecting logs for your execute
              command results. Valid values are `NONE`, `DEFAULT`, and
              `OVERRIDE`.
            END
          }

          attribute "log_configuration" {
            type        = object(log_configuration)
            description = <<-END
              The log configuration for the results of the execute command
              actions Required when `logging` is `OVERRIDE`.
            END

            attribute "cloud_watch_encryption_enabled" {
              type        = bool
              description = <<-END
                Whether or not to enable encryption on the CloudWatch logs. If 
                not specified, encryption will be disabled.
              END
            }

            attribute "cloud_watch_log_group_name" {
              type        = string
              description = <<-END
                The name of the CloudWatch log group to send logs to.
              END
            }

            attribute "s3_bucket_name" {
              type        = string
              description = <<-END
                The name of the S3 bucket to send logs to.
              END
            }

            attribute "s3_bucket_encryption_enabled" {
              type        = bool
              description = <<-END
                Whether or not to enable encryption on the logs sent to S3. If
                not specified, encryption will be disabled.
              END
            }

            attribute "s3_key_prefix" {
              type        = string
              description = <<-END
                An optional folder in the S3 bucket to place logs in.
              END
            }
          }
        }
      }
    }

    section {
      title = "Module Configuration"

      variable "module_enabled" {
        type        = bool
        default     = true
        description = <<-END
          Specifies whether resources in the module will be created.
        END
      }

      variable "module_tags" {
        type           = map(string)
        default        = {}
        description    = <<-END
          A map of tags that will be applied to all created resources that accept tags.
          Tags defined with `module_tags` can be overwritten by resource-specific tags.
        END
        readme_example = <<-END
          module_tags = {
            environment = "staging"
            team        = "platform"
          }
        END
      }

      variable "module_depends_on" {
        type           = list(dependency)
        description    = <<-END
          A list of dependencies.
          Any object can be _assigned_ to this list to define a hidden external dependency.
        END
        default        = []
        readme_example = <<-END
          module_depends_on = [
            null_resource.name
          ]
        END
      }
    }
  }

  section {
    title   = "Module Outputs"
    content = <<-END
      The following attributes are exported in the outputs of the module:
    END

    output "cluster" {
      type        = object(cluster)
      description = <<-END
        All outputs of the 'aws_ecs_cluster' resource.
      END
    }

    output "module_enabled" {
      type        = bool
      description = <<-END
        Whether this module is enabled.
      END
    }

    output "module_tags" {
      type        = map(string)
      description = <<-END
        The map of tags that are being applied to all created resources that accept tags.
      END
    }
  }

  section {
    title = "External Documentation"

    section {
      title   = "AWS Documentation"
      content = <<-END
        - https://docs.aws.amazon.com/AmazonECS/latest/developerguide/clusters.html
      END
    }

    section {
      title   = "Terraform AWS Provider Documentation"
      content = <<-END
        - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster
      END
    }
  }

  section {
    title   = "Module Versioning"
    content = <<-END
      This Module follows the principles of [Semantic Versioning (SemVer)].

      Given a version number `MAJOR.MINOR.PATCH`, we increment the:

      1. `MAJOR` version when we make incompatible changes,
      2. `MINOR` version when we add functionality in a backwards compatible manner, and
      3. `PATCH` version when we make backwards compatible bug fixes.
    END

    section {
      title   = "Backwards compatibility in `0.0.z` and `0.y.z` version"
      content = <<-END
        - Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
        - Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
      END
    }
  }

  section {
    title   = "About Mineiros"
    content = <<-END
      [Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
      that solves development, automation and security challenges in cloud infrastructure.

      Our vision is to massively reduce time and overhead for teams to manage and
      deploy production-grade and secure cloud infrastructure.

      We offer commercial support for all of our modules and encourage you to reach out
      if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
      [Community Slack channel][slack].
    END
  }

  section {
    title   = "Reporting Issues"
    content = <<-END
      We use GitHub [Issues] to track community reported issues and missing features.
    END
  }

  section {
    title   = "Contributing"
    content = <<-END
      Contributions are always encouraged and welcome! For the process of accepting changes, we use
      [Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
    END
  }

  section {
    title   = "Makefile Targets"
    content = <<-END
      This repository comes with a handy [Makefile].
      Run `make help` to see details on each available target.
    END
  }

  section {
    title   = "License"
    content = <<-END
      [![license][badge-license]][apache20]

      This module is licensed under the Apache License Version 2.0, January 2004.
      Please see [LICENSE] for full details.

      Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]
    END
  }
}

references {
  ref "homepage" {
    value = "https://mineiros.io/?ref=terraform-aws-ecs-cluster"
  }
  ref "hello@mineiros.io" {
    value = " mailto:hello@mineiros.io"
  }
  ref "badge-license" {
    value = "https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg"
  }
  ref "releases-terraform" {
    value = "https://github.com/hashicorp/terraform/releases"
  }
  ref "releases-aws-provider" {
    value = "https://github.com/terraform-providers/terraform-provider-aws/releases"
  }
  ref "apache20" {
    value = "https://opensource.org/licenses/Apache-2.0"
  }
  ref "slack" {
    value = "https://mineiros.io/slack"
  }
  ref "terraform" {
    value = "https://www.terraform.io"
  }
  ref "aws" {
    value = "https://aws.amazon.com/"
  }
  ref "semantic versioning (semver)" {
    value = "https://semver.org/"
  }
  ref "variables.tf" {
    value = "https://github.com/mineiros-io/terraform-aws-ecs-cluster/blob/main/variables.tf"
  }
  ref "examples/" {
    value = "https://github.com/mineiros-io/terraform-aws-ecs-cluster/blob/main/examples"
  }
  ref "issues" {
    value = "https://github.com/mineiros-io/terraform-aws-ecs-cluster/issues"
  }
  ref "license" {
    value = "https://github.com/mineiros-io/terraform-aws-ecs-cluster/blob/main/LICENSE"
  }
  ref "makefile" {
    value = "https://github.com/mineiros-io/terraform-aws-ecs-cluster/blob/main/Makefile"
  }
  ref "pull requests" {
    value = "https://github.com/mineiros-io/terraform-aws-ecs-cluster/pulls"
  }
  ref "contribution guidelines" {
    value = "https://github.com/mineiros-io/terraform-aws-ecs-cluster/blob/main/CONTRIBUTING.md"
  }
}
