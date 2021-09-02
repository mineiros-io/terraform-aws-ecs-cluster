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

variable "cluster_tags" {
  description = "(Optional) A map of tags to apply to all the created 'aws_ecs_cluster' resource. Default is {}."
  type        = map(string)
  default     = {}
}

variable "enable_container_insights" {
  description = "(Optional) Whether to use CloudWatch Container Insights to collect, aggregate, and summarize metrics and logs"
  type        = bool
  default     = true
}

# ----------------------------------------------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# See https://medium.com/mineiros/the-ultimate-guide-on-how-to-write-terraform-modules-part-1-81f86d31f024
# ----------------------------------------------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not. Default is true."
  default     = true
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends_on. Default is []."
  default     = []
}

variable "module_tags" {
  description = "(Optional) A map of default tags to apply to all resources created which support tags. Default is {}."
  type        = map(string)
  default     = {}
}
