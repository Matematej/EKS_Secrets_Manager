resource "aws_eks_node_group" "general" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "general"

  node_role_arn = aws_iam_role.eks_node_role.arn
  subnet_ids    = ["subnet-12345678", "subnet-87654321"]

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 10
  }

  instance_types = ["t3.small"]

  remote_access {
    ec2_ssh_key = "your_ssh_key_name"
  }

  tags = {
    Role = "general"
  }
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks_node_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}