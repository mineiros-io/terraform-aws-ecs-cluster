[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-aws-ecs-cluster)

[![Build Status](https://github.com/mineiros-io/terraform-aws-ecs-cluster/workflows/Tests/badge.svg)](https://github.com/mineiros-io/terraform-aws-ecs-cluster/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-aws-ecs-cluster.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-aws-ecs-cluster/releases)
[![Terraform Version](https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![AWS Provider Version](https://img.shields.io/badge/AWS-3-F8991D.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-aws/releases)
[![Join Slack](https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack)](https://mineiros.io/slack)

# terraform-aws-ecs-cluster

A [Terraform] module to create and manage an
[Amazon ECS Cluster](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/clusters.html)
on [Amazon Web Services (AWS)][aws].

**_This module supports Terraform version 1
and is compatible with the Terraform AWS Provider version 3.57.0**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.


- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Main Resource Configuration](#main-resource-configuration)
  - [Module Configuration](#module-configuration)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [AWS Documentation](#aws-documentation)
  - [Terraform AWS Provider Documentation](#terraform-aws-provider-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

This module implements the following Terraform resources

- `aws_ecs_cluster`

## Getting Started

Most common usage of the module:

```hcl
module "terraform-aws-ecs-cluster" {
  source = "git@github.com:mineiros-io/terraform-aws-ecs-cluster.git?ref=v0.0.1"

  name = "name-of-cluster"
}
```

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Main Resource Configuration

- [**`name`**](#var-name): *(**Required** `string`)*<a name="var-name"></a>

  Name of the cluster (up to 255 letters, numbers, hyphens, and
  underscores).

- [**`tags`**](#var-tags): *(Optional `map(string)`)*<a name="var-tags"></a>

  A map of tags to apply to all created resources.

  Default is `{}`.

- [**`enable_container_insights`**](#var-enable_container_insights): *(Optional `bool`)*<a name="var-enable_container_insights"></a>

  Whether to use CloudWatch Container Insights to collect, aggregate,
  and summarize metrics and logs.

  Default is `true`.

- [**`configuration`**](#var-configuration): *(Optional `object(configuration)`)*<a name="var-configuration"></a>

  The execute command configuration for the cluster.

  The `configuration` object accepts the following attributes:

  - [**`execute_command_configuration`**](#attr-configuration-execute_command_configuration): *(Optional `object(execute_command_configuration)`)*<a name="attr-configuration-execute_command_configuration"></a>

    The details of the execute command configuration.

    The `execute_command_configuration` object accepts the following attributes:

    - [**`kms_key_id`**](#attr-configuration-execute_command_configuration-kms_key_id): *(Optional `string`)*<a name="attr-configuration-execute_command_configuration-kms_key_id"></a>

      The AWS Key Management Service key ID to encrypt the data between
      the local client and the container.

    - [**`logging`**](#attr-configuration-execute_command_configuration-logging): *(Optional `string`)*<a name="attr-configuration-execute_command_configuration-logging"></a>

      The log setting to use for redirecting logs for your execute
      command results. Valid values are `NONE`, `DEFAULT`, and
      `OVERRIDE`.

    - [**`log_configuration`**](#attr-configuration-execute_command_configuration-log_configuration): *(Optional `object(log_configuration)`)*<a name="attr-configuration-execute_command_configuration-log_configuration"></a>

      The log configuration for the results of the execute command
      actions Required when `logging` is `OVERRIDE`.

      The `log_configuration` object accepts the following attributes:

      - [**`cloud_watch_encryption_enabled`**](#attr-configuration-execute_command_configuration-log_configuration-cloud_watch_encryption_enabled): *(Optional `bool`)*<a name="attr-configuration-execute_command_configuration-log_configuration-cloud_watch_encryption_enabled"></a>

        Whether or not to enable encryption on the CloudWatch logs. If 
        not specified, encryption will be disabled.

      - [**`cloud_watch_log_group_name`**](#attr-configuration-execute_command_configuration-log_configuration-cloud_watch_log_group_name): *(Optional `string`)*<a name="attr-configuration-execute_command_configuration-log_configuration-cloud_watch_log_group_name"></a>

        The name of the CloudWatch log group to send logs to.

      - [**`s3_bucket_name`**](#attr-configuration-execute_command_configuration-log_configuration-s3_bucket_name): *(Optional `string`)*<a name="attr-configuration-execute_command_configuration-log_configuration-s3_bucket_name"></a>

        The name of the S3 bucket to send logs to.

      - [**`s3_bucket_encryption_enabled`**](#attr-configuration-execute_command_configuration-log_configuration-s3_bucket_encryption_enabled): *(Optional `bool`)*<a name="attr-configuration-execute_command_configuration-log_configuration-s3_bucket_encryption_enabled"></a>

        Whether or not to enable encryption on the logs sent to S3. If
        not specified, encryption will be disabled.

      - [**`s3_key_prefix`**](#attr-configuration-execute_command_configuration-log_configuration-s3_key_prefix): *(Optional `string`)*<a name="attr-configuration-execute_command_configuration-log_configuration-s3_key_prefix"></a>

        An optional folder in the S3 bucket to place logs in.

### Module Configuration

- [**`module_enabled`**](#var-module_enabled): *(Optional `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created.

  Default is `true`.

- [**`module_tags`**](#var-module_tags): *(Optional `map(string)`)*<a name="var-module_tags"></a>

  A map of tags that will be applied to all created resources that accept tags.
  Tags defined with `module_tags` can be overwritten by resource-specific tags.

  Default is `{}`.

  Example:

  ```hcl
  module_tags = {
    environment = "staging"
    team        = "platform"
  }
  ```

- [**`module_depends_on`**](#var-module_depends_on): *(Optional `list(dependency)`)*<a name="var-module_depends_on"></a>

  A list of dependencies.
  Any object can be _assigned_ to this list to define a hidden external dependency.

  Default is `[]`.

  Example:

  ```hcl
  module_depends_on = [
    null_resource.name
  ]
  ```

## Module Outputs

The following attributes are exported in the outputs of the module:

- [**`cluster`**](#output-cluster): *(`object(cluster)`)*<a name="output-cluster"></a>

  All outputs of the 'aws_ecs_cluster' resource.

- [**`module_enabled`**](#output-module_enabled): *(`bool`)*<a name="output-module_enabled"></a>

  Whether this module is enabled.

- [**`module_tags`**](#output-module_tags): *(`map(string)`)*<a name="output-module_tags"></a>

  The map of tags that are being applied to all created resources that accept tags.

## External Documentation

### AWS Documentation

- https://docs.aws.amazon.com/AmazonECS/latest/developerguide/clusters.html

### Terraform AWS Provider Documentation

- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Slack channel][slack].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-aws-ecs-cluster
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[releases-aws-provider]: https://github.com/terraform-providers/terraform-provider-aws/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[terraform]: https://www.terraform.io
[aws]: https://aws.amazon.com/
[semantic versioning (semver)]: https://semver.org/
[variables.tf]: https://github.com/mineiros-io/terraform-aws-ecs-cluster/blob/main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-aws-ecs-cluster/blob/main/examples
[issues]: https://github.com/mineiros-io/terraform-aws-ecs-cluster/issues
[license]: https://github.com/mineiros-io/terraform-aws-ecs-cluster/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-aws-ecs-cluster/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-aws-ecs-cluster/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-aws-ecs-cluster/blob/main/CONTRIBUTING.md
