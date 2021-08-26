# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "cluster" {
  description = "All outputs of the 'aws_ecs_cluster' resource."
  value       = try(aws_ecs_cluster.cluster[0], {})
}

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------

output "module_enabled" {
  description = "Whether the module is enabled"
  value       = var.module_enabled
}

output "module_tags" {
  description = "A map of default tags to apply to all resources created which support tags."
  value       = var.module_tags
}
