resource "aws_dax_cluster" "dax" {
  cluster_name       = var.dax_name
  iam_role_arn       = aws_iam_role.dax_role.arn
  node_type          = "dax.t2.small"
  replication_factor = 2
}