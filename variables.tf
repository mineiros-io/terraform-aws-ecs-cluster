# ----------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables must be set when using this module.
# ----------------------------------------------------------------------------------------------------------------------

variable "name" {
  type        = string
  description = "(Required) Name of the cluster (up to 255 letters, numbers, hyphens, and underscores)."

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-_]{1,253}[a-zA-Z0-9]$", var.name))
    error_message = "The name of the cluster can have a max length of 255 characters, numbers, hyphens and underscores."
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These variables have defaults, but may be overridden.
# ----------------------------------------------------------------------------------------------------------------------

variable "tags" {
  description = "(Optional) A map of tags to apply to all created resources."
  type        = map(string)
  default     = {}
}

variable "enable_container_insights" {
  description = "(Optional) Whether to use CloudWatch Container Insights to collect, aggregate, and summarize metrics and logs"
  type        = bool
  default     = true
}

variable "configuration" {
  description = "KMS ID for the execute command logging configuration"
  type        = any
  # type = object({
  #   execute_command_configuration = optional(object({
  #     # (Optional) The AWS Key Management Service key ID to encrypt the data between the local client and the container.
  #     kms_key_id = optional(string)
  #     # (Optional) The log configuration for the results of the execute command actions Required when `logging` is `OVERRIDE`.
  #     log_configuration = optional(object({
  #       # (Optional) Whether or not to enable encryption on the CloudWatch logs. If not specified, encryption will be disabled.
  #       cloud_watch_encryption_enabled = optional(bool)
  #       # (Optional) The name of the CloudWatch log group to send logs to.
  #       cloud_watch_log_group_name = optional(string)
  #       # (Optional) The name of the S3 bucket to send logs to.
  #       s3_bucket_name = optional(string)
  #       # (Optional) Whether or not to enable encryption on the logs sent to S3. If not specified, encryption will be disabled.
  #       s3_bucket_encryption_enabled = optional(bool)
  #       # (Optional) An optional folder in the S3 bucket to place logs in.
  #       s3_key_prefix = optional(string)
  #     }))
  #   }))
  #   # (Optional) The log setting to use for redirecting logs for your execute command results. Valid values are `NONE`, `DEFAULT`, and `OVERRIDE`.
  #   logging = optional(string)
  # })
  default = null
}

# ----------------------------------------------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# ----------------------------------------------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not."
  default     = true
}

variable "module_tags" {
  type        = map(string)
  description = "(Optional) A map of tags that will be applied to all created resources that accept tags. Tags defined with 'module_tags' can be overwritten by resource-specific tags."
  default     = {}
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends_on."
  default     = []
}
