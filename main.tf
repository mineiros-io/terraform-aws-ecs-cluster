resource "aws_ecs_cluster" "cluster" {
  count = var.module_enabled ? 1 : 0

  name = var.name

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

  tags = merge(var.module_tags, var.cluster_tags)
}
